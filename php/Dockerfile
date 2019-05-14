#
# CentOS-7, Apache 2.4, PHP5.6
# =============================================================================
FROM centos:centos7
MAINTAINER Bibin Joseph <admin@newagesmb.com>

# -----------------------------------------------------------------------------
# Import the RPM GPG keys for Repositories
# -----------------------------------------------------------------------------

RUN yum -y install \
  http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
  http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm \
  http://rpms.remirepo.net/enterprise/remi-release-7.rpm 

# -----------------------------------------------------------------------------
# Apache + (PHP 5.6)
# -----------------------------------------------------------------------------

RUN yum -y install --enablerepo=remi,remi-php70 \
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
ENV HOME /var/www/html
ENV hostname=hiltonrds.cvb3x10otois.us-east-1.rds.amazonaws.com
ENV username=newageuser
ENV password=NeW#EAdm!N
ENV database=hiltondb
ENV base_url_deploy=http://34.227.102.54/

# -----------------------------------------------------------------------------
# Chnage AllowOverride None to AllowOverride All in httpd.conf
# -----------------------------------------------------------------------------


RUN sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf


# -----------------------------------------------------------------------------
# Start
# -----------------------------------------------------------------------------
COPY ["startup.sh", "/"]
RUN chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]

# forward request and error logs to docker log collector

RUN ln -sf /proc/self/fd/1 /var/log/httpd/access_log && \
    ln -sf /proc/self/fd/1 /var/log/httpd/error_log
