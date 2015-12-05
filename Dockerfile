FROM alpine:edge

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	apk update && \
	apk add git gcc g++ curl python-dev postgresql-dev libffi-dev musl-dev libzip-dev@testing zip \
	jpeg-dev libpng-dev libjpeg-turbo-dev tiff-dev freetype-dev lcms2-dev libwebp-dev tcl-dev tk-dev openjpeg-dev \
	openssl-dev libxml2-dev libxslt-dev rsync bash make openssh-client \
	zlib-dev sudo perl imagemagick-dev boost-dev graphicsmagick-dev@testing && \
	curl -O -sSL https://bootstrap.pypa.io/get-pip.py && \
	python get-pip.py && \
	pip install virtualenv pep8 pyflakes isort codecov