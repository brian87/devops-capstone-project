# Cloud DevOps Engineer Capstone Project

Capstone project for Cloud DevOps Engineer Nanodegree at Udacity.

## What did I learn?

- Using Circle CI to implement CI/CD
- Working with Ansible and CloudFormation to deploy clusters
- Building Kubernetes clusters
- Building Docker containers in pipelines

## Application

The application is a simple Flesk project based on python that display a html page with the text "Let's rock CI/CD". The base image is python:3.7-alpine

## Kubernetes Cluster

AWS CloudFormation was used to build the Kubernetes Cluster.
- **VPC and Networking**, to setup VPC, Subnets
- **EKS** to craete the Kubernetes Cluster and Nodes
- **Management** and EC2 Instance used to configure and manage the Cluster 

### Stacks
![CloudFormation](./screenshots/cf.png)

### EC2 intances
![EC2 Instances](./screenshots/cf.png)

#### List of deployed Stacks:

#### List of deployed Instances:

## CircleCi - CI/CD Pipelines

## Linting using Pylint and Hadolint


