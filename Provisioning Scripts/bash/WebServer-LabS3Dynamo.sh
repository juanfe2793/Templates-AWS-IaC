#!/bin/bash
# Script de prueba para instalar una aplicación web demo de Amazon. Script proporcionado por Amazon en su curso ACA. 
# Todos los derechos reservados. El uso de este script es con fines academicos.
# Instalación Apache Web Server.
yum install -y httpd
amazon-linux-extras install -y php7.2
# Descarga la aplicación ejemplo. *Desarrollada por el equipo de AWS.
wget https://s3-us-west-2.amazonaws.com/aws-tc-largeobjects/CUR-200-CCA-31-EN/lab1src.zip
unzip lab1src.zip -d /tmp/
mv /tmp/lab1src/*.php /var/www/html/
# Descarga e instala AWS SDK para PHP
wget https://github.com/aws/aws-sdk-php/releases/download/3.62.3/aws.zip
unzip aws -d /var/www/html
# Determine Region. *Cambiar el ID de la región según necesidad.
export AWS_DEFAULT_REGION = us-east-1
# Copia los archivos a un bucket de S3 *Cambiar al nombre del bucket deseado ("webapp-jgomez" es de ejemplo)
BUCKET=webapp-jgomez
aws s3 cp /tmp/lab1src/jquery/ s3://$BUCKET/jquery/ --recursive --acl public-read 
aws s3 cp /tmp/lab1src/images/ s3://$BUCKET/images/ --recursive --acl public-read 
aws s3 ls s3://$BUCKET/  --recursive
# Configuración de la región a utilizar
sed -i "2s/%region%/$REGION/g" /var/www/html/*.php
sed -i "3s/%bucket%/$BUCKET/g" /var/www/html/*.php
# Copia Datos en DynamoDB
aws dynamodb batch-write-item --request-items file:///tmp/lab1src/scripts/services1.json 
aws dynamodb batch-write-item --request-items file:///tmp/lab1src/scripts/services2.json 
aws dynamodb batch-write-item --request-items file:///tmp/lab1src/scripts/services3.json 
# Inicia el Servidor
chkconfig httpd on
service httpd start
#Instalación CodeDeploy Agent.
sudo yum install -y ruby
cd /home/ec2-user
wget https://$BUCKET.s3.us-west-2.amazonaws.com/latest/install
chmod a+x ./install
sudo ./install auto
sudo service codedeploy-agent start
sudo service codedeploy-agent status
