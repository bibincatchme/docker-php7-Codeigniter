#!/bin/bash 

set -e

databasefile=/var/www/html/application/config/database.php
configfile=/var/www/html/application/config/config.php

echo "Updating config.php file "
sed -i 's|base_url_deploy|'$base_url_deploy'|g' "$configfile"

echo "Updating database.php file "
sed -i "s~$(awk  -F "'"  '/\$db\[*.default.*\]\[*.hostname.*\]/ {print $6}' "$databasefile")~$hostname~g" "$databasefile"
sed -i "s~$(awk  -F "'"  '/\$db\[*.default.*\]\[*.username.*\]/ {print $6}' "$databasefile")~$username~g" "$databasefile"
sed -i "s~$(awk  -F "'"  '/\$db\[*.default.*\]\[*.password.*\]/ {print $6}' "$databasefile")~$password~g" "$databasefile"
sed -i "s~$(awk  -F "'"  '/\$db\[*.default.*\]\[*.database.*\]/ {print $6}' "$databasefile")~$database~g" "$databasefile"

exec /usr/sbin/httpd -DFOREGROUND
git clone jira.hilton.com/stash/scm/bo/hilton_fsdpe.git cd hilton_fsdpe docker build -t fsdpe . docker images λ docker images REPOSITORY TAG IMAGE ID CREATED SIZE fsdpe latest 6163384890c1 3 hours ago 701


#
# CentOS-7, Apache 2.4, PHP5.6
# =============================================================================
FROM dockerhub.hilton.com/centos:7.6.1810
MAINTAINER Bibin Joseph <admin@newagesmb.com>

# -----------------------------------------------------------------------------
# Managing different minor versions of php 7
# https://www.linuxtechi.com/install-php-7-centos-7-rhel-7-server/
#
ENV PHPVERSION remi-php56
RUN yum -y install \
 http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# -----------------------------------------------------------------------------
# Apache + (PHP 5.6)
# -----------------------------------------------------------------------------

RUN yum -y install --enablerepo=remi,${PHPVERSION} \
 php \
 php-cli \
 php-fpm \
 php-gd \
 php-mbstring \
 php-mcrypt \
 php-mysqlnd \
 php-opcache \
 php-pdo \
 php-pear \
 php-soap \
 php-xml \ 
 php-mssql \
 php-ldap 


RUN yum install httpd \
   yum clean all && \
   rm -rf /var/cache/yum

# -----------------------------------------------------------------------------
# Set ports and env variable HOME
# -----------------------------------------------------------------------------
EXPOSE 80
#ENV baseurl=url


# -----------------------------------------------------------------------------
# Chnage AllowOverride None to AllowOverride All in httpd.conf
# -----------------------------------------------------------------------------
#Copy Application Files
RUN rm -rf /var/www/html/*
COPY public_html /var/www/html/
COPY hilton.conf /etc/httpd/conf/httpd.conf


# -----------------------------------------------------------------------------
# Start
# -----------------------------------------------------------------------------
COPY ["startup.sh", "/"]
RUN chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]
