#!/bin/bash
#Descripcion: Este es un script que instala el agente de AWS CodeDeploy en una instancia EC2
#Instalación CodeDeploy Agent. Cambiar las variables de Bucket y Region según la necesidad. 
export AWS_DEFAULT_REGION = us-west-2
BUCKET=aws-codedeploy-us-west-2
sudo yum install -y ruby
cd /home/ec2-user
wget https://$BUCKET.s3.us-west-2.amazonaws.com/latest/install
chmod a+x ./install
sudo ./install auto
sudo service codedeploy-agent start
sudo service codedeploy-agent status
