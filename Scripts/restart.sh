#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: starts a container that has been stopped"
fi

sudo lxc-start -n $1
sudo echo "2560M" | sudo tee /sys/fs/cgroup/memory/lxc.payload.$1/memory.limit_in_bytes > /dev/null
