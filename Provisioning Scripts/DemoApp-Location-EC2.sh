#!/bin/bash -xe
#Descripcion: 
    yum update -y 
    yum install -y httpd php aws-cfn-bootstrap
    amazon-linux-extras install -y php7.2
    wget https://us-west-2-tcprod.s3.amazonaws.com/courses/AWS-100-CCA/v3.1.21/lab8-ha/scripts/phpapp.zip
    unzip phpapp.zip -d /var/www/html/
    chkconfig httpd on
    service httpd start