#!/bin/bash -xe
# Description: Este es un script para automatizar el proceso de instalación del servidor de integración continua con jenkins. 
# El script se pasa como UserData en una instancia EC2 de AWS. 
yum update -y
#Instalación java y nodejs.
yum install -y java-1.8.0-openjdk
#Instalación de NodeJS con nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node
npm install -g forever
#Descarga del repositorio de Jenkins y su instalación.
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm -import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
#Configurar Jenkins para que arranque en el inicio de la instancia. 
chkconfig jenkins on
#Iniciar Servicio Jenkins
service jenkins start
