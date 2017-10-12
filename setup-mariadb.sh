#!/bin/bash

apt install -y --no-install-recommends software-properties-common apt-utils
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository -y -u 'deb [arch=amd64,i386,ppc64el] http://sgp1.mirrors.digitalocean.com/mariadb/repo/10.2/ubuntu xenial main'
apt update
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< "mariadb-server-10.0 mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mariadb-server-10.0 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt -y --no-install-recommends install mariadb-server