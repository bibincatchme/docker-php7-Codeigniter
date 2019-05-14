#!/bin/bash
databasefile=/var/www/html/application/config/database.php
sed -i "s~$(awk  -F "'"  '/\$db\[*.default.*\]\[*.hostname.*\]/ {print $6}' "$databasefile")~$hostname~g" "$databasefile"
sed -i "s~$(awk  -F "'"  '/\$db\[*.default.*\]\[*.username.*\]/ {print $6}' "$databasefile")~$username~g" "$databasefile"
sed -i "s~$(awk  -F "'"  '/\$db\[*.default.*\]\[*.password.*\]/ {print $6}' "$databasefile")~$password~g" "$databasefile"
sed -i "s~$(awk  -F "'"  '/\$db\[*.default.*\]\[*.database.*\]/ {print $6}' "$databasefile")~$database~g" "$databasefile"



#$db['default']['username'] = 'newageuser';
#$config['base_url']= 'http://'. $_SERVER['SERVER_NAME'] .'/hilton/';

configfile=/var/www/html/application/config/config.php
sed -i "s~$(awk  -F "'"  '/\$config\[*.base_url.*\]/ {print $4}' "$configfile")~$base_url_deploy~g" "$configfile"

#sed -i 's|base_url_deploy|'$base_url_deploy'|g' "$configfile"

/usr/sbin/httpd -DFOREGROUND

# forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/httpd/access.log \
#	&& ln -sf /dev/stderr /var/log/httpd/error.log

#RUN ln -sf /proc/self/fd/1 /var/log/httpd/access.log && \
#    ln -sf /proc/self/fd/1 /var/log/httpd/error.log
