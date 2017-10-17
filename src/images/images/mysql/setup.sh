#!/bin/bash
# Edited by tthoma24 9/22/17
# A simple shell script to provision a dedicated MySQL docker container
# Credit: https://coreos.com/quay-enterprise/docs/latest/mysql-container.html

# Pull the Oracle MySQL docker image
docker pull mysql:5.7
set -e

# Setup MySQL DB name and users:
MYSQL_USER="dbuser"
MYSQL_DATABASE="db"
MYSQL_CONTAINER_NAME="mysql"

# Creates a 32 character password from /dev/urandom, sanitizing output using tr, and taking only the first line using sed
MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9!*=' | fold -w 32 | sed 1q)
MYSQL_PASSWORD=$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9!*=' | fold -w 32 | sed 1q)

echo "Start the Oracle MySQL container:"
# It will provision a blank database upon first start.
# This initial provisioning can take up to 30 seconds.

docker \
    run \
    --detach \
    --env MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
    --env MYSQL_USER=${MYSQL_USER} \
    --env MYSQL_PASSWORD=${MYSQL_PASSWORD} \
    --env MYSQL_DATABASE=${MYSQL_DATABASE} \
    --name ${MYSQL_CONTAINER_NAME} \
    --publish 3306:3306 \
    mysql:5.7;

echo "Sleeping for 10 seconds to allow time for the DB to be provisioned:"
for i in `seq 1 10`;
do
    echo "."
    sleep 1
done

echo "Database '${MYSQL_DATABASE}' running."
echo "  Username: ${MYSQL_USER}"
echo "  Password: ${MYSQL_PASSWORD}"
