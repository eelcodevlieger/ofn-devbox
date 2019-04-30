This repo is designed to help Windows or Mac users get a dev environment up and running quickly using Vagrant.

#### Setup:

- Install Virtualbox, Vagrant, and Git.
- Vagrant commands need to be run from an Administrator terminal on Windows.
- Start the box with the command: `vagrant up` (inside this directory).
- Wait for the installation to finish...
- Profit!

The setup should create a new local directory `/openfoodnetwork`, which will contain the app files. This will be synced to a directory in the guest box.
The vagrant box will start up a Rails server and make it available at `localhost:3000` on the host machine. 

Once it's set up you can change into the `/openfoodnetwork` directory and set it up for working with github:

```
git config --global color.ui true
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR@EMAIL.com"
git remote add upstream https://github.com/openfoodfoundation/openfoodnetwork.git
git remote add origin https://github.com/YOUR-USERNAME/openfoodnetwork.git

```

#### Vagrant general usage

The following commands are useful for managing your virtual server with Vagrant:
```sh
# Shut down the VM:
vagrant halt

# Restart the VM:
vagrant reload

# Delete the VM:
vagrant destroy

# Retry the provisioning (setup) stage:
vagrant up --provision
```

You can also connect to the VM via SSH using the command: `vagrant ssh`. 
