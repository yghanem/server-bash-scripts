#!/bin/bash
sudo apt-get -y update
sudo apt-get install git -y
sudo apt-get install apache2 -y
sudo service apache2 restart
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt php5-mysql php5-curl -y
sudo groupadd www
sudo usermod -a -G www ubuntu
sudo chown -R root:www /var/www
sudo chmod 2775 /var/www
sudo find /var/www -type d -exec chmod 2775 {} +
sudo find /var/www -type f -exec chmod 0664 {} +
sudo chmod 2775 /var/www/html
sudo rm -r /var/www/html
sudo git clone --single-branch --depth=1 -b STABLE https://github.com/phpmyadmin/phpmyadmin.git  /var/www/html
sudo mkdir /var/www/htm/config
sudo chmod o+rw /var/www/config
sudo chmod 777 /var/lib/php5
sudo cp /var/www/html/config.sample.inc.php /var/www/html/config.inc.php
sudo service apache2 restart
