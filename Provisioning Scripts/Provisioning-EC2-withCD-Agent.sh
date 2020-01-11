#!/bin/bash
# Description: Este es un script para automatizar el aprovionamiento básico de aplicaciones, que habilita el despliegue automatico usando CodeDeploy.
# El script se pasa como UserData en una instancia EC2 de AWS con S.O. RedHat. 
sudo yum update -y
#Instalación software generico.
sudo yum install -y wget git curl gcc bind-utils
sudo yum install -y make openssh-server
#Instalacion java y nodejs.
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y nodejs
sudo npm install -g forever
#Instalación Software web server
sudo yum install -y httpd php
sudo service httpd start
sudo chkconfig httpd on
#Instalación y Configuración CodeDeploy Agent.
sudo yum -y install ruby
cd /home/ec2-user
sudo wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
#El bucket S3 utilizado para descargar el agente depende de la regiónAWS donde se despliega la instancia.
sudo chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start