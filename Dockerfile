FROM alpine:edge
MAINTAINER George Kutsurua <g.kutsurua@gmail.com>

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories &&\
    apk add --no-cache sudo bash curl make perl rsync openssl openssh-client nginx \
                       libpq libffi libffi-dev libxml2 libxml2-dev libbz2 \
                       libxslt libxslt-dev libtool libstdc++ zlib zlib-dev git unzip \
                       libjpeg libjpeg-turbo libjpeg-turbo-dev openjpeg openjpeg-dev \
                       libpng libpng-dev tiff tiff-dev freetype freetype-dev lcms2 lcms2-dev \
                       libwebp libwebp-dev tcl tcl-dev imagemagick imagemagick-dev imagemagick-c++ \
                       json-c json-c-dev jsoncpp jsoncpp-dev python python-dev musl musl-dev \
                       postgis-dev@testing linux-headers gcc g++ &&\
    wget -O - https://bootstrap.pypa.io/get-pip.py | python

ENV LANG=en_US.utf8 \
    LC_ALL=en_US.utf8 \
    LANGUAGE=en_US.utf8

COPY requirements.txt /requirements.txt
COPY gitlab-runner-helper /usr/bin/gitlab-runner-helper

RUN pip install --upgrade -r /requirements.txt
