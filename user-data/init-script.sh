#!/bin/bash
#
sudo dnf install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo echo "Hello World" > /var/www/html/index.html
