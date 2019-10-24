#!/bin/bash
# Install Apache Web Server and PHP
yum install -y httpd
amazon-linux-extras install -y php7.2
# Download Lab files
wget https://s3-us-west-2.amazonaws.com/aws-tc-largeobjects/CUR-200-CCA-31-EN/lab1src.zip
unzip lab1src.zip -d /tmp/
mv /tmp/lab1src/*.php /var/www/html/
# Download and install the AWS SDK for PHP
wget https://github.com/aws/aws-sdk-php/releases/download/3.62.3/aws.zip
unzip aws -d /var/www/html
# Determine Region
export AWS_DEFAULT_REGION = us-east-1
# Copy files to Amazon S3 bucket with name webapp-*
BUCKET=webapp-jgomez
aws s3 cp /tmp/lab1src/jquery/ s3://$BUCKET/jquery/ --recursive --acl public-read 
aws s3 cp /tmp/lab1src/images/ s3://$BUCKET/images/ --recursive --acl public-read 
aws s3 ls s3://$BUCKET/  --recursive
# Configure Region and Bucket to use
sed -i "2s/%region%/$REGION/g" /var/www/html/*.php
sed -i "3s/%bucket%/$BUCKET/g" /var/www/html/*.php
# Copy data into DynamoDB table
aws dynamodb batch-write-item --request-items file:///tmp/lab1src/scripts/services1.json 
aws dynamodb batch-write-item --request-items file:///tmp/lab1src/scripts/services2.json 
aws dynamodb batch-write-item --request-items file:///tmp/lab1src/scripts/services3.json 
# Turn on web server
chkconfig httpd on
service httpd start
