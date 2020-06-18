# Kalique
Pronounced as /kal'ik/.

Kalique is a text generator written in Ruby on Rails.

## Installing
Install ruby 2.6.1, sqlite3, node.js, yarn


### In Vagrant

Copy packaged zip to `/home/vagrant/`

Then
```
sudo su
unzip kalique.zip
source "/etc/profile.d/rvm.sh"
gem install bundler
bundle install
yarn install

rails test # for tests

rails s # to start the server
```

