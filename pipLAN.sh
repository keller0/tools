#!/bin/sh

USR=cai
DEST=192.168.2.100
PATH=/home/cai/plShare
LPATH=/home/cai/plShare

if [[ "$1" == "-f" && -n $2 ]]; then
	echo $2 $USR@$DEST:$PATH
    exit
fi

if [[ "$1" == "-c" && -n $2 ]]; then
	echo $2 > $LPATH/clipboard
    exit
fi

echo "help: -f to trans file, -c to trans string"
