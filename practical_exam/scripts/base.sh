#!/bin/bash

sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1

apt update -y
apt upgrade -y

curl -fsSL https://get.docker.com -o get-docker.sh 
sh get-docker.sh

apt -y update
apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

groupadd docker
usermod -aG docker ubuntu

apt install conntrack

curl --silent -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.13/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

curl --silent -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh