#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage ./script container name"
fi
sudo echo "$2" > /var/lib/lxc/$1/rootfs/etc/hostname

FILE=/var/lib/lxc/$1/rootfs/etc/hosts
sudo tail -n +2 "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"

sudo lxc-stop -n $1
sleep 5
sudo lxc-start -n $1
