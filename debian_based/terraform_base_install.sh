#!/bin/bash

AZ_REPO=$(lsb_release -cs)

touch ~/lorenzo/.hushlogin &&
sudo apt update && sudo apt upgrade -y &&
sudo apt install -y \
apt-transport-https \
ca-certificates \
curl \
software-properties-common \
gnupg \
net-tools \
wget \
python3-dev \
python3-pip &&

# Install Docker && Docker-Compose
curl -sSL https://raw.githubusercontent.com/docker/docker-install/master/install.sh | sudo bash &&
sudo usermod -aG docker lorenzo &&
curl -sSL https://raw.githubusercontent.com/dcodev1702/install_docker/main/install_docker-compose.sh | sudo bash &&
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" &&
sudo dpkg -i packages-microsoft-prod.deb &&
rm packages-microsoft-prod.deb &&
sudo apt-get update &&

# Install PowerShell and Azure Modules
sudo apt-get install -y powershell &&
sudo pwsh -c Install-Module Az -Scope AllUsers -Force &&
sudo pwsh -c Install-Module Az.ConnectedMachine -Scope AllUsers -Force &&

# Install Azure CLI
sudo mkdir -p /etc/apt/keyrings &&
curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null &&
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg &&
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list &&
sudo apt-get update &&
sudo apt-get install -y azure-cli
