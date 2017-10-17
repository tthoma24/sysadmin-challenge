#!/bin/sh
# Collect log files for Apache and MySQL and send them daily to an S3 bucket
# Written by tthoma24 9/22/17

# Setup variables
DATE=`date +%Y%m%d`

# tar up the log files
tar -C /var/lib/docker/volumes/apache-logs/_data/ -czf /tmp/apache-${DATE}.tar.gz .
tar -C /var/lib/docker/volumes/mysql-logs/_data/ -czf /tmp/mysql-${DATE}.tar.gz .

# copy the log files to S3
aws s3 cp /tmp/apache-${DATE}.tar.gz s3://interview-logs/apache/${DATE}.tar.gz
aws s3 cp /tmp/mysql-${DATE}.tar.gz s3://interview-logs/mysql/${DATE}.tar.gz

# remove tmp files
rm /tmp/apache-${DATE}.tar.gz
rm /tmp/mysql-${DATE}.tar.gz
