FROM ubuntu:xenial
MAINTAINER George Kutsurua <g.kutsurua@gmail.com>

RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y openssl openssh-client rsync sudo perl make wget &&\
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - &&\
    wget --quiet -O - http://nginx.org/keys/nginx_signing.key | sudo apt-key add - &&\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DB82666C

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list &&\
    echo "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx" >> /etc/apt/sources.list &&\
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ xenial nginx" >> /etc/apt/sources.list &&\
    apt-get update &&\
    apt-get upgrade -y

RUN apt-get install -y libpq5 libpq-dev libffi6 libffi-dev libxml2 libxml2-dev libbz2-1.0 libbz2-dev \
                    libxslt1-dev libxslt1.1 libtool libstdc++6 libstdc++6-4.7-dev zlib1g zlib1g-dev \
                    git-core unzip libjpeg8 libjpeg8-dev libjpeg-turbo-progs libopenjpeg-dev \
                    libpng12-0 libpng12-dev libtiff5 libtiff5-dev libfreetype6 libfreetype6-dev \
                    liblcms2-2 liblcms2-dev libwebp5 libwebp-dev tcl8.4-dev tcl8.4 imagemagick libmagick++-dev \
                    curl libjson-c2 libjson-c-dev \
                    postgresql-9.6-postgis-2.3 postgresql-contrib-9.6 postgresql-client-9.6 postgresql-plpython3-9.6 \
                    postgresql-server-dev-9.6 build-essential python2.7-dev nginx glusterfs-client fuse &&\
    curl -O -sSL https://bootstrap.pypa.io/get-pip.py &&\
    chmod +x ./get-pip.py &&\
    ./get-pip.py

COPY requirements.txt /requirements.txt
COPY gitlab-runner-helper /usr/bin/gitlab-runner-helper

RUN pip install --upgrade -r /requirements.txt
