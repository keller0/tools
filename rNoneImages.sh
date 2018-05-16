#!/bin/sh
# docker remove none none images
docker rmi $(docker images | grep '<none>' | awk '{print $3}')
