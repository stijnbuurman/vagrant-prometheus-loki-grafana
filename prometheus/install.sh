#!/usr/bin/env bash

# download prometheus installation files
cd /home/vagrant
sudo rm -rf prometheus*
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.9.1/prometheus-2.9.1.linux-amd64.tar.gz

# Extract files + cleanup
sudo tar -xvzf /home/vagrant/prometheus-2.9.1.linux-amd64.tar.gz
sudo rm -rf /home/vagrant/prometheus-2.9.1.linux-amd64.tar.gz
sudo mv prometheus-2.9.1.linux-amd64 prometheus

# Create user + etc/var/lib folders
sudo id -u prometheus &>/dev/null || sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

# create prometheus symlinks for config and stuff
sudo rm -f /usr/bin/prometheus
sudo ln -s /home/vagrant/prometheus/prometheus /usr/bin
sudo chown prometheus:prometheus /usr/bin/prometheus
sudo rm -rf /etc/prometheus/consoles
sudo rm -rf /etc/prometheus/console_libraries
sudo cp -r /home/vagrant/prometheus/consoles /etc/prometheus
sudo cp -r /home/vagrant/prometheus/console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

# Move the config and service file
sudo rm -f /etc/prometheus/prometheus.yml
sudo cp /vagrant/prometheus/prometheus.yml /etc/prometheus/prometheus.yml
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
sudo cp /vagrant/prometheus/prometheus.service /etc/systemd/system/prometheus.service



# auto start prometheus
sudo systemctl daemon-reload
sudo systemctl enable prometheus