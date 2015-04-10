############################################################
# Dockerfile: CentOS6/MySQL/PHP/PHPMyAdmin
# Based on "carbonsphere/docker-centos6-php-nginx"
# 		This adds mysql server & PHPMyAdmin
############################################################
FROM carbonsphere/docker-centos6-php-nginx

MAINTAINER CarbonSphere <CarbonSphere@gmail.com>

# Add Environment Variables
ENV MYSQL_ROOT_PASSWORD      carbon

# Install MySQL
RUN yum -y install mysql-server mysql-client; yum -y clean all

# Install PHP
RUN yum -y --enablerepo=remi,remi-php56 install php-cli php-pear php-pdo php-mysqlnd php-pgsql php-gd php-mbstring php-mcrypt php-xml; yum -y clean all

# Add EPEL Release
RUN yum -y install epel-release; yum -y install phpmyadmin; yum -y clean all

# Modify supervisord.conf
RUN echo -e "\n[program:mysqld] \ncommand=/usr/bin/mysqld_safe\nstartsecs=0\nnumprocs=1 \nautostart=true\nautorestart=true" >> /etc/supervisord.conf

# Modify my.cfg
RUN echo -e "\nsocket=/var/lib/mysql/mysql.sock" >> /etc/my.cfg

# add phpmyadmin softlink to web directory
RUN ln -s /usr/share/phpMyAdmin /var/www; mv /var/www/index.php /var/www/phpinfo.php;

# Add new index.php to redirect to phpMyAdmin
RUN echo -e "<?php\nheader('Location: /phpMyAdmin/index.php');\n?>" > /var/www/index.php

# Add create user & db script to root
ADD createUserDb.sh /
RUN chmod +x /createUserDb.sh

# MySQL:3360
EXPOSE 3306

# Add Session directory
RUN mkdir /var/lib/php/session; chmod 777 /var/lib/php/session

# Start MySQL
RUN service mysqld start; \
    sleep 5; \
    /usr/bin/mysqladmin -u root password ${MYSQL_ROOT_PASSWORD};