# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
HOST_PORT = 3001

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define 'ofn-devbox'
  config.vm.box = 'ubuntu/xenial64'
  config.vm.hostname = 'ofn-devbox'
  config.ssh.insert_key = false
  config.vm.network 'forwarded_port', guest: 3000, host: HOST_PORT
  config.vm.network 'private_network', ip: '192.168.50.7'

  # Create synced app folder
  config.vm.synced_folder "openfoodnetwork/", "/home/vagrant/openfoodnetwork", id: "openfoodnetwork", create: true

  config.vm.provider :virtualbox do |vbox|
    # Disable virtualbox logging to file
    vbox.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]

    # Set box memory.
    vbox.customize ['modifyvm', :id, '--memory', '1792']

    # Optimise virtualbox.
    vbox.customize [ 'modifyvm', :id, '--nictype1', 'virtio' ]
    vbox.customize [ 'modifyvm', :id, '--nictype2', 'virtio' ]
  end

  # Set up and install OFN (one time only)
  config.vm.provision 'setup', type: 'shell', path: 'setup/provision.sh', privileged: false

  # Launch daemonized Rails server (whenever the box is started)
  config.vm.provision 'launch', type: 'shell', privileged: false, run: 'always', inline: <<-SHELL
      # Shut down any stale Rails instances on port 3000
      if [[ -n $(lsof -i tcp:3000 -t) ]];then
        echo '### Shutting down current Rails server instance...'
        kill -9 $(lsof -i tcp:3000 -t)
      fi

      # Load shims
      export PATH="$HOME/.rbenv/bin:~/.rbenv/shims:$PATH"

      # Start Rails server (daemonized)
      echo '### Starting Rails server...'
      cd ~/openfoodnetwork
      rails server -d

      echo '### Rails server is now available at host address: http://localhost:#{HOST_PORT}...'
  SHELL

end
