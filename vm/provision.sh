#!/bin/bash

echo "Provisioning the VM"

echo "Updating the VM"
sudo apt-get update

echo "Installing the packages"
sudo apt-get install -y ca-certificates curl wget unzip zip

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Installing docker"
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || {
  echo " Docker installation failed"
  exit 1
}


echo "Starting and Enabling docker service"
sudo systemctl start docker
sudo systemctl enable docker

echo "verify docker ->"
sudo docker info

echo "Disabling firewall"
if command -v ufw &> /dev/null; then
  sudo ufw disable
  sudo systemctl stop ufw
  sudo systemctl disable ufw
fi

# # pull the docker image from the docker hub
# echo "Pulling the Docker image"
# sudo docker pull akhilk2802/pad:latest

# # run the docker container
# echo "Running the Docker container"
# sudo docker run -d -p 3000:3000 --name pad-container akhilk2802/pad:latest

# echo "Verifying Docker is running"
# sudo docker ps

