FROM ubuntu:trusty
MAINTAINER George Kutsurua <g.kutsurua@gmail.com>

RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y wget &&\
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - &&\
    wget --quiet -O - http://nginx.org/keys/nginx_signing.key | sudo apt-key add - &&\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DB82666C

RUN echo "deb http://ppa.launchpad.net/fkrull/deadsnakes-python2.7/ubuntu trusty main" >> /etc/apt/sources.list &&\
    echo "deb-src http://ppa.launchpad.net/fkrull/deadsnakes-python2.7/ubuntu trusty main" >> /etc/apt/sources.list &&\
    echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> /etc/apt/sources.list &&\
    echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list &&\
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list &&\
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - &&\
    apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y libpq5 libpq-dev libffi6 libffi-dev libxml2 libxml2-dev libbz2-1.0 libbz2-dev \
                    libxslt1-dev libxslt1.1 libtool libstdc++6 libstdc++6-4.7-dev zlib1g zlib1g-dev \
                    git-core unzip libjpeg8 libjpeg8-dev libjpeg-turbo-progs libopenjpeg2 libopenjpeg-dev \
                    libpng12-0 libpng12-dev libtiff5 libtiff5-dev libfreetype6 libfreetype6-dev \
                    liblcms2-2 liblcms2-dev libwebp5 libwebp-dev tcl8.4-dev tcl8.4 imagemagick libmagick++-dev \
                    curl libjson-c2 libjson-c-dev openssl openssh-client rsync sudo perl make \
                    postgresql-9.5-postgis-2.2 postgresql-contrib-9.5 postgresql-client-9.5 postgresql-plpython3-9.5 \
                    postgresql-server-dev-9.5 build-essential python2.7-dev nginx &&\
    curl -O -sSL https://bootstrap.pypa.io/get-pip.py &&\
    chmod +x ./get-pip.py &&\
    ./get-pip.py &&\
    pip install virtualenv pep8 pyflakes isort codecov
