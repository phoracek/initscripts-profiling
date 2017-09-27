# -*- mode: ruby -*-
# vi: set ft=ruby :

$SET_DEFAULT_DIR = <<SCRIPT
echo 'cd /vagrant' >> /root/.bash_profile
echo 'cd /vagrant' >> /home/vagrant/.bash_profile
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.provider "libvirt" do |libvirt|
    libvirt.cpu_mode = 'host-passthrough'
  end

  config.vm.provision "shell", inline: $SET_DEFAULT_DIR

end
