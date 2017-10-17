# Deployment Manual

## Instructions to install and configure servers and services
* Login to AWS Console and Select EC2
* Create an instance with the following specs:
	* Image: Ubuntu 16.04
	* Type: t2.micro
	* Disk: 16 GB magnetic
* Name the instance with tag "Name" and value equal to what you would like to show up in the AWS console
* Select the appropriate SSH key so you may SSH into the Ubuntu user
* Once the machine is up, ssh to the appropriate IP using the command ssh ubuntu@ipaddress
* Once logged into the machine, follow the Getting Started Guide to install icinga and icinga web at https://www.icinga.com/docs/icinga2/latest/doc/02-getting-started/
	* Note: Due to icinga web preferring php-fpm, you will need to make sure to apt-get install libapache2-mod-php

## Create the S3 buckets
* Create two S3 buckets, one for the logs and one for the docker container backups. (See https://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html)
* Go to IAM > Policies in the AWS console, and create a new policy. Use the "Create your own policy option.
* Paste in the policy included in the S3policy.json file, changing the ARN of the buckets to the ones you created, if appropriate.
* Name and Validate the policy
* Now, create an IAM role under IAM > Roles. (See https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-service.html)
	* We want to delegate to an AWS Service, specifically EC2
	* Attach the Policy you created above to it.

## Assign the IAM role to the EC2 instance
* https://aws.amazon.com/blogs/security/easily-replace-or-attach-an-iam-role-to-an-existing-ec2-instance-by-using-the-ec2-console/

## Setup the docker Machine
* Login to AWS Console and Select EC2
* Create an instance with the following specs:
	* Image: Ubuntu 16.04
	* Type: t2.micro
	* Disk: 16 GB magnetic
	* Name the instance with tag "Name" and value equal to what you would like to show up in the AWS console
	* Select the appropriate SSH key so you may SSH into the Ubuntu user
* Once the machine is up, ssh to the appropriate IP using the command ssh ubuntu@ipaddress
* Create the data dir with sudo mkdir /data and chown it to ubuntu using sudo chown ubuntu:ubuntu /data
* Once you have verified you can get in, copy the Src directory to the docker machine using rsync -avz /path/to/src /data
* Install docker and the awscli using sudo apt-get update && apt-get install docker.io awscli
* Once docker is installed, create the apache container by running sudo /data/images/apache/setup.sh
* Create the MySQL container by running sudo /data/images/myql/setup.sh
* Copy the cron job for the logs using sudo cp /data/scripts/dockerlogs.cron.d /etc/cron.d
* Copy the cron job for the docker container backup using sudo cp /data/scripts/dockerbackups.cron.d /etc/cron.d

## Configure Icinga to monitor the docker host and containers
* Edit the icinga hosts.conf file to change the docker machine's IP
* Copy the icinga hosts.conf to the icinga machine using scp /path/to/hosts.conf /tmp
* Place the icinga hosts.conf file into the conf dir using sudo cp /tmp/hosts.conf /etc/icinga2/conf.d/hosts.conf
* Restart icinga2 using the command sudo systemctl restart icinga2.service

## Issues found in the system
* A bug in icinga web prevented the webpage from initially loading. A blank page with a one line path to a PHP script is displayed. Installing libapache2-mod-php as suggested in https://bugs.launchpad.net/ubuntu/+source/icingaweb2/+bug/1574250resolved the issue.

## Assumptions made 
* When following the deployment guide, you have the code on your local machine
* You already have an AWS account and an SSH key pair provisioned, as this would likely be the case in an enterprise enviornment
* The default Apache page was good enough; I didn't know what the MySQL and Apache would be used for.
* HTTPS was not necessary (even though this is a best practice, and I would revisit it given more time)
* HTTP Basic auth for the Apache web server was acceptable. In an enterprise production setup, hooking into LDAP or AD might be better
* Using AWS instance profiles to assign IAM roles to the docker machine, rather than managing IAM creds in plain textfiles for the S3 backups and log uploas

## Requirements not covered 
* What web app would run on the Apache container
* What the MySQL container's db would be used for
* Setting up HTTPS
* Where the Ansible playbook and required files would be stored and run from
