#!/bin/bash
# Constantes
export AWS_DEFAULT_REGION = us-east-1
# Install Apache Web Server and PHP
yum -y update
yum -y install httpd php
amazon-linux-extras install -y php7.2

#Download web app

#wget https://us-west-2-tcprod.s3.amazonaws.com/courses/AWS-100-CCA/v3.1.21/lab8-ha/scripts/phpapp.zip
unzip phpapp.zip -d /var/www/html/
service httpd start

# Turn on web server
chkconfig httpd on
service httpd start