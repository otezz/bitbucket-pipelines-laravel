#!/bin/bash

apt-get install -y --no-install-recommends software-properties-common apt-utils
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
echo "deb http://kodeterbuka.beritagar.id/mariadb/repo/$MARIADB_VERSION/debian jessie main" > /etc/apt/sources.list.d/mariadb.list
apt-get update
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< "mariadb-server-10.0 mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mariadb-server-10.0 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt-get -y --no-install-recommends install mariadb-server