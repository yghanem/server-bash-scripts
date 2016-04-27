#!/bin/bash
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password <root_password>'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password <root_password>'
sudo apt-get -y update
sudo apt-get -y install iptables-persistent
sudo apt-get -y install mysql-server
sudo mysql_install_db
sudo sed -i "s/.*bind-address.*/#bind-address = 127.0.0.1/" /etc/mysql/my.cnf
mysql -uroot -p<root_password> -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '<root_password>' WITH GRANT OPTION;"
sudo mysql -uroot -p<root_password> -e "FLUSH PRIVILEGES;"
sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
sudo invoke-rc.d iptables-persistent save
sudo service mysql restart
