# Containerization and Monitoring Challenge

## Overall Objective
Setup Docker containers for MySQL and Apache, and setup a monitoring solution for the environment using Icinga.

## Deployment
See Deployment.md for the deployment manual

## Functional Requirements
* Icinga should monitor the Apache Web Server and the MySQL Database server 
* Logs for Apache and MySQL should be sent to Amazon S3, daily at 7pm, automatically using Bash Scripting.
* Webpages should be password protected
* Ensure proper backups are taken and sent to Amazon S3
* Deployment of Docker containers should be automated using configuration management (e.g Chef, Puppet, Ansible, etc.)

## Other Technical and Non-functional Requirements
* Assume missing/unclear requirements to fill the gaps in the specifications.
* Troubleshoot any system issues to ensure availability of services
* Demonstrate your Administration and scripting skills by choosing a good design.
* Plan to setup servers, install services, configure them so as to create the system from scratch.
* Choose a mix of services to use for hands-on, shell scripting, NodeJS, Python that you need to create as part of the system for an efficient design.