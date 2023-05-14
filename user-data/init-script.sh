#!/bin/bash

# On AL2023 Ec2 only
#
#sudo dnf update
#
### install all needed packages
#sudo dnf install -y \
#  git \
#  nginx \
#  php8.1 \
#  php8.1-common \
#  php8.1-cli \
#  php8.1-fpm \
#  php8.1-mbstring \
#  php8.1-opcache \
#  php8.1-pdo \
#  php8.1-xml \
#  php8.1-gd \
#  php-pear \
#  php8.1-mysqlnd \
#  mariadb105 \
#  mariadb105-server \
#  augeas-libs
#
#sudo systemctl start php-fpm
#sudo systemctl enable php-fpm
#
#sudo systemctl start nginx
#sudo systemctl enable nginx
#
#sudo systemctl start mariadb
#sudo systemctl enable mariadb
#
### Install certbot for nginx
#
#sudo python3 -m venv /opt/certbot/
#sudo /opt/certbot/bin/pip install --upgrade pip
#
#sudo /opt/certbot/bin/pip install certbot certbot-nginx
#
## link so that you can run the certbot command directly
#sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot
#
#


# On AL2 Ec2 only
sudo amazon-linux-extras install -y \
  php8.1 \
  mariadb10.5 \

sudo yum install -y \
  git \
  augeas-libs

sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --setopt="remi-php82.priority=5" --enable remi-php82

sudo yum install -y \
  nginx \
  php-imap \
  php-pear \
  php-xml \
  php-opcache \
  php-gd \
  php-mbstring

sudo systemctl start php-fpm
sudo systemctl enable php-fpm

sudo systemctl start nginx
sudo systemctl enable nginx

sudo systemctl start mariadb
sudo systemctl enable mariadb

### Install certbot for nginx

sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip install --upgrade pip urllib3==1.26.15

sudo /opt/certbot/bin/pip install certbot certbot-nginx

## link so that you can run the certbot command directly
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot
