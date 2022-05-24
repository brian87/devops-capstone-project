# The Makefile includes instructions on: environment setup, install, lint and build
CLUSTER_NAME=ml
REGION_NAME=eu-west-1
KEYPAIR_NAME=key-pair-eu-west-1
DEPLOYMENT_NAME=ml-api
NEW_IMAGE_NAME=registry.hub.docker.com/brian87/ml-api:latest
CONTAINER_PORT=80
HOST_PORT=8080
KUBECTL=./bin/kubectl

setup:
	# Create a python virtualenv & activate it
	python3 -m venv ~/.devops-capstone
	# source ~/.devops-capstone/bin/activate 

install:
	# This should be run from inside a virtualenv
	echo "Installing: dependencies..."
	pip install --upgrade pip && pip install -r requirements.txt
	# pip install "ansible-lint[community,yamllint]"
	echo
	pytest --version
	# ansible --version
	# ansible-lint --version
	echo
	echo "Installing: shellcheck"
	./scripts/install_shellcheck.sh
	echo
	echo "Installing: hadolint"
	./scripts/install_hadolint.sh
	echo
	echo "Installing: kubectl"
	./scripts/install_kubectl.sh
	echo
	echo "Installing: eksctl"
	./scripts/install_eksctl.sh
	
test:
	# Additional, optional, tests could go here
	#python -m pytest 

lint:
	# https://github.com/koalaman/shellcheck: a linter for shell scripts
	./scripts/shellcheck -Cauto -a ./scripts/*.sh
	# https://github.com/hadolint/hadolint: a linter for Dockerfiles
	./scripts/hadolint Dockerfile
	# https://www.pylint.org/: a linter for Python source code 
	pylint --output-format=colorized --disable=C app.py

run-app:
	python3 app.py

build-docker:
	./scripts/build_docker.sh

run-docker: build-docker
	./scripts/run_docker.sh

upload-docker: build-docker
	./scripts/upload_docker.sh

ci-validate:
	# Required file: .circleci/config.yml
	circleci config validate

k8s-deployment: eks-create-cluster
	# If using minikube, first run: minikube start
	./scripts/k8s_deployment.sh

port-forwarding: 
	# Needed for "minikube" only
	${KUBECTL} port-forward service/${DEPLOYMENT_NAME} ${HOST_PORT}:${CONTAINER_PORT}

rolling-update:
	${KUBECTL} get deployments -o wide
	${KUBECTL} set image deployments/${DEPLOYMENT_NAME} ${DEPLOYMENT_NAME}=${NEW_IMAGE_NAME}
	echo
	${KUBECTL} get deployments -o wide
	${KUBECTL} describe pods | grep -i image
	${KUBECTL} get pods -o wide

rollout-status:
	${KUBECTL} rollout status deployment ${DEPLOYMENT_NAME}
	echo
	${KUBECTL} get deployments -o wide

rollback:
	${KUBECTL} get deployments -o wide
	${KUBECTL} rollout undo deployment ${DEPLOYMENT_NAME}
	${KUBECTL} describe pods | grep -i image
	echo
	${KUBECTL} get pods -o wide
	${KUBECTL} get deployments -o wide

k8s-cleanup-resources:
	./scripts/k8s_cleanup_resources.sh

eks-create-cluster:
	./scripts/eks_create_cluster.sh

eks-delete-cluster:
	./bin/eksctl delete cluster --name "${CLUSTER_NAME}" --region "${REGION_NAME}"