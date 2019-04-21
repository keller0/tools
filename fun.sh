#!/bin/sh

nohup sslocal -c /etc/ss.json > /var/log/ss.log 2>&1
