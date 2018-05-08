#!/bin/sh
# find out which program is using a specific port
port=$1
pid=$(lsof -i :${port} | grep 'LISTEN' | awk '{print $2}')
if [ ${#pid} -eq 0 ]
then
	echo "Port ${port} are not in use"
	exit 0
else
	ps -o command ${pid} | sed -n 2p
fi
