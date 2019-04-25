#!/usr/bin/env bash
sudo apt-get update -y
sudo apt-get install git -y

/vagrant/grafana/install.sh
/vagrant/node_exporter/install.sh
/vagrant/prometheus/install.sh
/vagrant/loki/install.sh

sudo systemctl start grafana-server
sudo systemctl start node_exporter
sudo systemctl start prometheus
sudo systemctl start loki
sudo systemctl start promtail
