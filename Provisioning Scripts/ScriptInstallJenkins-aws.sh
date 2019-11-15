#!/bin/bash
# Description: Este es un script para automatizar el proceso de instalacion del servidor de integracion continua con jenkins. 
# El script se pasa como UserData en una instancia EC2 de AWS con S.O. RedHat. 
yum update -y
#Instalacion java y nodejs.
yum install -y java-1.8.0-openjdk 
yum install -y nodejs wget git
npm install -g forever
#Descarga del repositorio de Jenkins y su instalacion.
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm -import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
#Configurar permisos para conexion con repositorio CodeCommit. Es necesario para que AWS acepte las claves HTTPs del usuario.
sudo -u jenkins git config --global credential.helper '!aws codecommit credential-helper $@'
sudo -u jenkins git config --global credential.useHttpPath true
sudo -u jenkins git config --global user.email "me@mycompany.com"
sudo -u jenkins git config --global user.name "MyJenkinsServer"
#Configurar Jenkins para que arranque en el inicio de la instancia. 
chkconfig jenkins on
#Iniciar Servicio Jenkins
service jenkins start