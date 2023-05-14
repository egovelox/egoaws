#!/bin/bash
#
sudo dnf update

sudo dnf install -y \
  git \
  nginx \
  php8.1 \
  php8.1-common \
  php8.1-cli \
  php8.1-fpm \
  php8.1-mbstring \
  php8.1-opcache \
  php8.1-pdo \
  php8.1-xml \
  php-pear \
  php8.1-mysqlnd \
  mariadb105 \
  mariadb105-server

sudo systemctl start php-fpm
sudo systemctl enable php-fpm

sudo systemctl start nginx
sudo systemctl enable nginx

sudo systemctl start mariadb
sudo systemctl enable mariadb
