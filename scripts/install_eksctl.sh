#!/usr/bin/env bash

test -e ./bin/eksctl ||
    {
        curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C ./bin
        chmod +x ./bin/eksctl
    }

echo "./bin/eksctl: $(./bin/eksctl version)"