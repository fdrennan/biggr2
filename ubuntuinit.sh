<<<<<<< HEAD
#!/bin/bash

set -o errexit

readonly LOG_FILE="/var/log/biggr2.log"

# Create the destination log file that we can
# inspect later if something goes wrong with the
# initialization.
sudo touch $LOG_FILE

# Open standard out at `$LOG_FILE` for write.
# This has the effect 
exec 1>$LOG_FILE

# Redirect standard error to standard out such that 
# standard error ends up going to wherever standard
# out goes (the file).
exec 2>&1

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    make \
    gcc \
    libz-dev \
    gnupg \
    ca-certificates \
    git \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    libsodium-dev \
    libpq-dev \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    net-tools \
    gdebi \
    r-base \
    r-base-dev


sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo groupadd docker | echo already in group
sudo usermod -aG docker ubuntu

# INSTALL NVIDIA DRIVERS
sudo apt-get install --no-install-recommends nvidia-driver-418 -y

# Install NVIDIA Docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker

