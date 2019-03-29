This repo is designed to help Windows or Mac users get a dev environment up and running quickly using Vagrant.

#### Usage:

- Install Vagrant and Virtualbox.
- Start the box with the command: `vagrant up` (inside this directory).
- Wait for the installation to finish...
- Profit!

The setup should create a new local directory `/openfoodnetwork`, which will contain the app files. This will be synced to a directory in the guest box.
The vagrant box will start up a Rails server and make it available at `localhost:3001` on the host machine. 
