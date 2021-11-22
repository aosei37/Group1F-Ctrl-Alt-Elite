#!/bin/bash
if [ $# -ne 3 ]
then
        echo "Usage: Script control files database"
fi

# $1 is control
# $2 is files
# $3 is database
sudo echo "2560M" | sudo tee /sys/fs/cgroup/memory/lxc.payload.$1/memory.limit_in_bytes > /dev/null
sudo echo "2560M" | sudo tee /sys/fs/cgroup/memory/lxc.payload.$2/memory.limit_in_bytes > /dev/null
sudo echo "2560M" | sudo tee /sys/fs/cgroup/memory/lxc.payload.$3/memory.limit_in_bytes > /dev/null
