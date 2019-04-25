#!/usr/bin/env bash

# download grafana
cd /home/vagrant
rm -rf grafana*
wget https://dl.grafana.com/oss/release/grafana_6.1.4_amd64.deb

sudo apt-get install -y adduser libfontconfig

# install grafana
sudo dpkg -i /home/vagrant/grafana_6.1.4_amd64.deb

# auto start grafana
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable grafana-server
