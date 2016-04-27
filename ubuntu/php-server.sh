#!/bin/bash
sudo apt-get -y update
sudo apt-get install apache2 -y
sudo service apache2 restart
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
sudo groupadd www
sudo usermod -a -G www ubuntu
sudo chown -R root:www /var/www
sudo chmod 2775 /var/www
sudo find /var/www -type d -exec chmod 2775 {} +
sudo find /var/www -type f -exec chmod 0664 {} +
sudo chmod 2775 /var/www/html
sudo echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
