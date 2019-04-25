# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
  config.vm.box_check_update = true

  config.vm.network "forwarded_port", guest: 9090, host: 9090 # prometheus
  config.vm.network "forwarded_port", guest: 3000, host: 3000 # grafana
  config.vm.network "forwarded_port", guest: 3100, host: 3100 # loki
  config.vm.network "forwarded_port", guest: 9100, host: 9100 # node_exporter
  config.vm.network "forwarded_port", guest: 9080, host: 9080 # promtail

  config.vm.provider "virtualbox" do |v|
    v.customize [
        "modifyvm", :id,
        "--nictype1", "virtio",
        "--memory", "2048"
    ]
  end


  config.vm.provision :shell, path: "bootstrap.sh"
end
