#!/bin/bash


sudo apt install -y git

sudo apt install -y python3

wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && sudo dpkg -i packages-microsoft-prod.deb && sudo apt-get update && sudo add-apt-repository universe && sudo apt-get install -y powershell && rm -rf packages-microsoft-prod.deb

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

sudo apt-get update && sudo apt-get install -y apt-transport-https && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && sudo apt-get update && sudo apt-get install -y kubectl

sudo apt update && sudo apt install apt-transport-https ca-certificates curl software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" && sudo apt update && apt-cache policy docker-ce && sudo apt install -y docker-ce
