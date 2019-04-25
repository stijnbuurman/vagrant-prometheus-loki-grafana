#!/usr/bin/env bash

# download node_exporter installation files
cd /home/vagrant
rm -rf node_exporter*
wget https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz

# Extract files + cleanup
tar -xvzf /home/vagrant/node_exporter-0.17.0.linux-amd64.tar.gz
sudo rm -rf /home/vagrant/node_exporter-0.17.0.linux-amd64.tar.gz
sudo mv node_exporter-0.17.0.linux-amd64 node_exporter

# Create user
sudo id -u node_exporter &>/dev/null || sudo useradd --no-create-home --shell /bin/false node_exporter

# create a symbolic link of node_exporter
sudo rm -f /usr/bin/node_exporter
sudo ln -s /home/vagrant/node_exporter/node_exporter /usr/bin
sudo chown node_exporter:node_exporter /usr/bin/node_exporter

# create service
sudo cp /vagrant/node_exporter/node_exporter.service /etc/systemd/system/node_exporter.service

# auto start
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
