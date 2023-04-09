#!/bin/bash

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo rpm -Uvh https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm
sudo dnf install powershell -y
