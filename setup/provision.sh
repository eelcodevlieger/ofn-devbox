#!/bin/bash

echo '### Install dependencies'

sudo apt-get update
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev git postgresql-9.5 postgresql-common libpq-dev phantomjs


echo '### Install rbenv'

cd ~
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

echo '### Install ruby-build plugin'

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

echo '### Install rbenv-gem-rehash plugin'

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

echo '### Build Ruby 2.1.5 via rbenv (this make take a while...)'

rbenv install 2.1.5
rbenv global 2.1.5
ruby -v


echo '### Install nodenv'

git clone https://github.com/nodenv/nodenv.git ~/.nodenv --depth 1
(cd ~/.nodenv && src/configure && make -C src)
echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(nodenv init -)"' >> .bashrc
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

echo '### Install node-build plugin'

git clone https://github.com/nodenv/node-build.git "$(nodenv root)/plugins/node-build" --depth 1

echo '### Build Node 5.12.0 via nodenv'

nodenv install 5.12.0


echo '### Export shims to $PATH and update bash'

echo 'export PATH="$HOME/.nodenv/shims:$PATH"' >> ~/.bashrc
export PATH="$HOME/.nodenv/shims:$PATH"
echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc
export PATH="$HOME/.rbenv/shims:$PATH"


echo '### Fetch OFN repo'

git clone git://github.com/openfoodfoundation/openfoodnetwork.git ~/openfoodnetwork


echo '### Set up application.yml'

cp /vagrant/setup/application.yml ~/openfoodnetwork/config/application.yml


echo '### Create ofn postgres user'

sudo -u postgres psql -c "CREATE USER ofn WITH SUPERUSER CREATEDB PASSWORD 'f00d'"


echo '### Run the OFN setup script'

cd ~/openfoodnetwork

export AUTO_ACCEPT=true
./script/setup

skylight disable_dev_warning


exit 0
