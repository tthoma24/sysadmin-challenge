FROM ubuntu:latest
MAINTAINER Teddy Thomas (tthoma24@mit.edu)
# Cache bust the apt cache and install most recent version of apache2
RUN apt-get update && apt-get install -y apache2
# Setup Apache Environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENTRYPOINT /usr/sbin/apache2ctl -D FOREGROUND
EXPOSE 80