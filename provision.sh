#!/bin/bash

set -e
set -x


echo "provisioning!"

#sudo python3 -m http.server 80 &

sudo apt-get update 
sudo apt-get -y upgrade
yes | sudo apt-get install nginx
yes | sudo apt-get install python-pip

sudo mkdir -p /var/www
sudo mkdir -p /var/www/hello_world
# sudo chown -R ubuntu:ubuntu /var/www/hello_world
cd /var/www/hello_world

sudo cp /vagrant/hello.py hello.py
sudo cp /vagrant/nginx_config nginx_config

yes | sudo apt-get install python-virtualenv
virtualenv venv
. venv/bin/activate

yes | sudo pip install flask
pip freeze > requirements.txt

yes | sudo pip install gunicorn
gunicorn hello:app -p hello.pid -b 0.0.0.0:8000 -D

sudo cp nginx_config /etc/nginx/sites-available/nginx_config
sudo ln -s \
    /etc/nginx/sites-available/nginx_config \
    /etc/nginx/sites-enabled/nginx_config

echo "provisioning complete!"

