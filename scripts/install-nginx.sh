#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo wget https://raw.githubusercontent.com/nginxinc/NGINX-Demos/master/nginx-hello/index.html --output-document /usr/share/nginx/html/index.html
sudo wget https://raw.githubusercontent.com/nginxinc/NGINX-Demos/master/nginx-hello/hello.conf --output-document /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
