#!/bin/bash

# Update system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install NGINX
sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key -y
sudo apt-get update -y
sudo apt-get install nginx -y
sudo ufw allow 'Nginx HTTP'

# Configure default site
sudo wget https://raw.githubusercontent.com/nginxinc/NGINX-Demos/master/nginx-hello/index.html --output-document /usr/share/nginx/html/index.html
sudo wget https://raw.githubusercontent.com/nginxinc/NGINX-Demos/master/nginx-hello/hello.conf --output-document /etc/nginx/sites-enabled/default

# Restart nginx service
sudo systemctl restart nginx
