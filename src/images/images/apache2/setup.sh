#!/bin/bash
# Written by tthoma24 9/22/17
docker build -t apache .
docker run -p 80:80 -d apache
