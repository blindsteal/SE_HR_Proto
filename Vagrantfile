# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty32"
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/trusty32/versions/1/providers/virtualbox.box"

  config.vm.provider :virtualbox do |vb|
    # This allows symlinks to be created within the /vagrant root
    # directory, which is something librarian-puppet needs to be 
    # able to do.
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end
  
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  
  # install puppet and librarian-puppet
  # config.vm.provision :shell, :path => "shell/install-puppet.sh"
  config.vm.provision :shell, :path => "shell/install-librarian-puppet.sh"

  # provision with Puppet stand alone
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "default.pp"
    # puppet.options = "--hiera_config /etc/hiera.yaml"
  end
  
  config.vm.provision :shell, :path => "shell/bootstrap-app.sh", :privileged => false
end
