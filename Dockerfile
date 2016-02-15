FROM alpine:3.3
MAINTAINER George Kutsurua <g.kutsurua@gmail.com>

ENV POSTGIS_VERSION=2.2.1 \
    GEOS_VERSION=3.5.0 \
    PROJ4_VERSION=4.9.2 \
    GDAL_VERSION=2.0.2

RUN apk update && apk upgrade && \
	apk add curl libxml2 json-c libxml2-dev json-c-dev alpine-sdk autoconf automake libtool \
	git postgresql-dev postgresql-contrib libffi-dev musl-dev \
	zip jpeg-dev libpng-dev libjpeg-turbo-dev tiff-dev \
	freetype-dev lcms2-dev libwebp-dev tcl-dev openjpeg-dev \
	openssl-dev libxml2-dev libxslt-dev rsync bash openssh-client \
	zlib-dev sudo perl imagemagick-dev python python-dev && \
	curl -O -sSL https://bootstrap.pypa.io/get-pip.py && \
	chmod +x ./get-pip.py && ./get-pip.py && \
	pip install virtualenv pep8 pyflakes isort codecov

RUN mkdir -p /tmp/build && cd /tmp/build && \
    curl -o postgis-${POSTGIS_VERSION}.tar.gz -sSL http://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz && \
    curl -o geos-${GEOS_VERSION}.tar.gz -sSL https://github.com/libgeos/libgeos/archive/${GEOS_VERSION}.tar.gz && \
    curl -o proj4-${PROJ4_VERSION}.tar.gz -sSL https://github.com/OSGeo/proj.4/archive/${PROJ4_VERSION}.tar.gz && \
    curl -o gdal-${GDAL_VERSION}.tar.gz -sSL http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz && \
    export PATH=/usr/local/pgsql/bin/:$PATH && \
    tar xzf proj4-${PROJ4_VERSION}.tar.gz && \
    tar xzf geos-${GEOS_VERSION}.tar.gz && \
    tar xzf gdal-${GDAL_VERSION}.tar.gz && \
    tar xzf postgis-${POSTGIS_VERSION}.tar.gz && \
    cd /tmp/build/proj.4* && ./configure --enable-silent-rules && make -s && make -s install && \
    cd /tmp/build/libgeos* && ./autogen.sh && ./configure --enable-silent-rules CFLAGS="-D__sun -D__GNUC__"  CXXFLAGS="-D__GNUC___ -D__sun" && make -s && make -s install && \
    cd /tmp/build/gdal* && ./configure --enable-silent-rules --with-static-proj4=/usr/local/lib && make -s && make -s install && \
    cd /tmp/build/postgis* && ./autogen.sh && ./configure --enable-silent-rules --with-projdir=/usr/local && \
    cd /tmp/build/postgis* && \
    echo "PERL = /usr/bin/perl" >> extensions/postgis/Makefile && \
    echo "PERL = /usr/bin/perl" >> extensions/postgis_topology/Makefile && make -s && make -s install && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/build
