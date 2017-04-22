FROM ubuntu:xenial

MAINTAINER Seto Kuslaksono <kuslaksono@gmail.com>

ADD setup-mariadb.sh /setup-mariadb.sh

ENV MARIADB_VERSION 10.1
ENV MYSQL_ROOT_PASSWORD root

# Update and Fix Language
RUN \
 apt-get update && apt-get -y upgrade &&\
 apt-get install -y --no-install-recommends locales &&\
 echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen &&\
 locale-gen en_US.UTF-8 &&\
 /usr/sbin/update-locale LANG=en_US.UTF-8

# Install mariadb
RUN ["/bin/bash", "-c", "bash /setup-mariadb.sh"]

# Install PHP
RUN \
  apt-get update && \
  apt-get install -y git zip && \
  apt-get install -y php7.0-mysqlnd php7.0-cli php7.0-sqlite php7.0-mbstring php7.0-mcrypt php7.0-curl php7.0-intl php7.0-gd php-xdebug php7.0-zip php7.0-xml && \
  apt-get autoclean && apt-get clean && apt-get autoremove

# Install composer
RUN apt-get update && apt-get install -y curl && \
    curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin

# Install PHPUnit
RUN apt-get update && apt-get install -y curl && \
    curl https://phar.phpunit.de/phpunit.phar > phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit

# Install NodeJS
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install -y nodejs

# Install yarn
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Clean up
RUN \
 apt-get autoclean && apt-get clean && apt-get autoremove