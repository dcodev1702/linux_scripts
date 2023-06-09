#!/bin/bash

sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo dnf install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $(whoami)

sudo systemctl enable docker
sudo systemctl start docker
