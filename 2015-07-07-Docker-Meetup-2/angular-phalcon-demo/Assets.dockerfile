FROM ubuntu:14.04
MAINTAINER Boyan Bonev <b.bonev@redbuffstudio.com>

#Setup container environment parameters
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

#Configure locale.
RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

#Prepare the image
RUN apt-get -y update


#=====General utilities=====#
RUN apt-get install -y -q python-software-properties software-properties-common bash-completion wget nano \
curl libcurl3 libcurl3-dev build-essential libpcre3-dev


# Install VCS
RUN apt-get install -y -q git subversion
#=====END=====#

RUN echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key E5267A6C
RUN apt-get -y update
RUN apt-get install -y -q php5-cli php5-fpm php5-dev php5-mysql php5-pgsql php5-mongo php5-curl php5-gd php5-intl php5-imagick php5-mcrypt php5-memcache php5-xmlrpc php5-xsl
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

#Install phalcon
RUN git clone git://github.com/phalcon/cphalcon.git /tmp/cphalcon
RUN cd /tmp/cphalcon/build && git checkout 1.3.4
RUN cd /tmp/cphalcon/build && ./install
RUN echo "extension=phalcon.so" > /etc/php5/mods-available/phalcon.ini && php5enmod phalcon

#=====Ruby 2.2.2 Installation (with RVM)=====#
RUN apt-get install -y -q libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.2.2"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

#=====END=====#


#=====Node v0.10.33 install=====#
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get install -y -q nodejs

RUN npm install -g napa@1.2.0 --save-dev
RUN npm install -g gulp@3.9.0
#=====END=====#

#Application volume
ADD ./development/docker/bin/assets.sh /
RUN chmod 755 /assets.sh

ENTRYPOINT ["/assets.sh"]

CMD ["assets:gulp"]
