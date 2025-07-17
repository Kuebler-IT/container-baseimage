#!/bin/bash -e
# this script is run during the image build

# config
sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/8.2/fpm/php.ini

# replace default website with php service default website
cp -f /container/service/php/config/default /etc/nginx/sites-available/default

# create phpinfo.php
echo "<?php phpinfo(); " > /var/www/html/phpinfo.php
