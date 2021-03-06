#!/bin/sh

DEST=cai@192.168.2.100
PATH=/home/cai/plShare
LPATH=/home/cai/plShare

if [[ "$1" == "-f" && -n $2 ]]; then
	echo scp $2 $DEST:$PATH
    exit
fi

if [[ "$1" == "-c" && -n $2 ]]; then
	echo $2 > $LPATH/clipboard
	echo scp $LPATH/clipboard $DEST:$PATH
    exit
fi

echo "help: -f to trans file, -c to trans string"
