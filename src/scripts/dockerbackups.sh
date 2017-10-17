#!/bin/sh
# Save docker container images daily to an S3 bucket
# Written by tthoma24 9/22/17

# Setup variables
DATE=`date +%Y%m%d`

# Save the container image
sudo docker save -o /tmp/apache-container-${DATE}.tar apache
sudo docker save -o /tmp/mysql-container-${DATE}.tar mysql

# copy the log files to S3
aws s3 cp /tmp/apache-container-${DATE}.tar s3://interview-docker-backups/apache/apache-container-${DATE}.tar
aws s3 cp /tmp/mysql-container-${DATE}.tar s3://interview-docker-backups/mysql/mysql-conatiner-${DATE}.tar

# remove tmp files
rm /tmp/apache-container-${DATE}.tar
rm /tmp/mysql-container-${DATE}.tar
