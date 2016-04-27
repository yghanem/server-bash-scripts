#!/bin/bash

#Set Root password for install change <root_password> with you password
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password <root_password>'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password <root_password>'
#Update apt-get
sudo apt-get -y update
#Install required libraries
sudo apt-get -y install iptables-persistent
sudo apt-get -y install mysql-server
#Initialize MySQL Data Directory
sudo mysql_install_db
#Allowing external connections
sudo sed -i "s/.*bind-address.*/#bind-address = 127.0.0.1/" /etc/mysql/my.cnf
#Give root % PRIVILEGES
mysql -uroot -p<root_password> -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '<root_password>' WITH GRANT OPTION;"
sudo mysql -uroot -p<root_password> -e "FLUSH PRIVILEGES;"
#Open port 3306
sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
#Open save iptables rules
sudo invoke-rc.d iptables-persistent save
sudo service mysql restart
