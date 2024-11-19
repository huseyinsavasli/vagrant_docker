#!/bin/bash

# Sistem güncellemeleri
sudo apt-get update
sudo ufw disable
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Docker icin GPG anahtarini ekleme
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Docker deposunu ekleme
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker yükleme
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Docker Compose yükleme
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
newgrp docker
sudo systemctl status docker
sudo systemctl start docker

# Hostname degistirme
echo "============= Hostname degistiriliyor... ============="
sudo hostnamectl set-hostname husosan

# SSH yapilandirmasi
echo "============= SSH ayarlari yapiliyor ============="
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl reload sshd

# Ek araclar yükleniyor
echo "============= Araclar yükleniyor... ============="
sudo apt install -y net-tools curl wget fail2ban htop nmap openssh-server

# Docker imajini calistirma
echo "============= Docker imaji calistiriliyor... ============="
docker run -d -p 7000:7000 onuromertunc/rd-helloworld:671

docker ps

