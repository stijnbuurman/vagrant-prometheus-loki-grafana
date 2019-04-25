#!/usr/bin/env bash

# download
cd /home/vagrant
rm -rf go1*
wget https://dl.google.com/go/go1.12.4.linux-amd64.tar.gz

# install go
sudo rm -rf  /home/vagrant/go
sudo tar -C /usr/local -xzf go1.12.4.linux-amd64.tar.gz

# download loki
sudo rm -rf /usr/local/go/src/github.com/grafana/loki
/usr/local/go/bin/go get github.com/grafana/loki
cd /home/vagrant/go/src/github.com/grafana/loki # GOPATH is $HOME/go by default.

# build loki
/usr/local/go/bin/go build ./cmd/loki
/usr/local/go/bin/go build ./cmd/promtail

# Create user + etc/var/lib folders
sudo id -u loki &>/dev/null || sudo useradd --no-create-home --shell /bin/false loki
sudo mkdir -p /etc/loki
sudo id -u promtail &>/dev/null || sudo useradd --no-create-home --shell /bin/false promtail
sudo mkdir -p /etc/promtail

# Move loki to /usr/bin
sudo rm -rf /usr/bin/loki
sudo ln -s  /home/vagrant/go/src/github.com/grafana/loki/loki /usr/bin
sudo chown loki:loki /usr/bin/loki

# Move promtail to /usr/bin
sudo rm -rf /usr/bin/promtail
sudo ln -s  /home/vagrant/go/src/github.com/grafana/loki/promtail /usr/bin
sudo chown promtail:promtail /usr/bin/promtail

# Move the loki config and service file
sudo rm -f /etc/loki/loki.yml
sudo cp /vagrant/loki/loki.yml /etc/loki/loki.yml
sudo chown loki:loki /etc/loki/loki.yml
sudo cp /vagrant/loki/loki.service /etc/systemd/system/loki.service

# Move the promtail config and service file
sudo rm -f /etc/promtail/promtail.yml
sudo cp /vagrant/loki/promtail.yml /etc/promtail/promtail.yml
sudo chown promtail:promtail /etc/promtail/promtail.yml
sudo cp /vagrant/loki/promtail.service /etc/systemd/system/promtail.service



# auto start loki and promtail
sudo systemctl daemon-reload
sudo systemctl enable loki
sudo systemctl enable promtail