FROM alpine:3
MAINTAINER Vivian Lim <me@vvn.space>
# based on:
# https://github.com/vortexau/SMF-Docker
# arvindr226/php-5.6-alpine

RUN apk add --update --no-cache bash \
				curl \
				curl-dev \
				php82-common \
				php82-pdo \
				php82-opcache \
				php82-zip \
				php82-phar \
				php82-iconv \
				php82-cli \
				php82-curl \
				php82-openssl \
				php82-mysqli \
				php82-mbstring \
				php82-tokenizer \
				php82-fileinfo \
				php82-json \
				php82-xml \
				php82-xmlwriter \
				php82-simplexml \
				php82-dom \
				php82-pdo_mysql \
				php82-pdo_sqlite \
				php82-tokenizer \
				php82-pecl-redis \
  				apache2 \
  				apache2-ctl \
  				apache2-proxy \
				libxml2-dev \
				apache2-utils \
				ca-certificates \
				wget \
				supervisor

RUN apk add --update --no-cache \
				php82-fpm

RUN apk add --update --no-cache imagemagick-dev \
				ffmpeg
RUN ln -s /usr/bin/php82 /usr/bin/php
RUN ln -s /usr/bin/php-fpm82 /usr/sbin/php-fpm

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN  rm -rf /var/cache/apk/*

RUN update-ca-certificates

RUN mkdir -p /var/www/html

# Download and install SMF
# RUN mkdir -p /var/www/html \
#     && cd /var/www/html \
#     && wget "https://download.simplemachines.org/index.php/smf_2-0-15_install.tar.gz" \
#     && tar zxf smf_2-0-15_install.tar.gz

# # Set the permissions SMF wants. They say 777 suggested!
# RUN chmod 777 /var/www/html/attachments \
#     /var/www/html/avatars \
#     /var/www/html/cache \
#     /var/www/html/Packages \
#     /var/www/html/Packages/installed.list \
#     /var/www/html/Smileys \
#     /var/www/html/Themes \
#     /var/www/html/agreement.txt \
#     /var/www/html/Settings.php \
#     /var/www/html/Settings_bak.php

# AllowOverride ALL
RUN sed -i '264s#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf
#Rewrite Module Enable
RUN sed -i 's#\#LoadModule rewrite_module modules/mod_rewrite.so#LoadModule rewrite_module modules/mod_rewrite.so#' /etc/apache2/httpd.conf
# Document Root to /var/www/html/
RUN sed -i 's#/var/www/localhost/htdocs#/var/www/html#g' /etc/apache2/httpd.conf
# Listen on port 8000
RUN sed -i 's#^Listen 80#Listen 8000#g' /etc/apache2/httpd.conf
RUN sed -i 's|^#LoadModule ext_filter_module|LoadModule ext_filter_module|' /etc/apache2/httpd.conf
RUN sed -i 's|^LoadModule mpm_prefork_module modules/mod_mpm_prefork.so$|# LoadModule mpm_prefork_module modules/mod_mpm_prefork.so|' /etc/apache2/httpd.conf
RUN sed -i 's|^#LoadModule mpm_event_module modules/mod_mpm_event.so$|LoadModule mpm_event_module modules/mod_mpm_event.so|' /etc/apache2/httpd.conf
RUN sed -i 's|^LogLevel warn$|LogLevel debug|' /etc/apache2/httpd.conf
#RUN sed -i 's|^# Mutex default.*$|Mutex default:/tmp/apache2|' /etc/apache2/httpd.conf

RUN sed -i 's|nobody|apache|' /etc/php82/php-fpm.d/www.conf
RUN sed -Ei '/^;extension=(mysqli|gd|zip)/s/^;//g' /etc/php82/php.ini

COPY ./apache-php-fpm.conf /etc/apache2/conf.d
# TODO: configure php.ini with recommendations https://wiki.simplemachines.org/smf/SMF2.1:Requirements_and_recommendations

#Start apache
RUN mkdir -p /run/apache2
RUN chown apache /run/apache2

EXPOSE 8000/tcp

#CMD ["/usr/sbin/apachectl","-DFOREGROUND"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]