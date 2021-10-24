#!/bin/bash



sysctl -w net.ipv4.ip_forward=1

sudo ip addr add 128.8.37.114/27 brd + dev enp4s2
sudo ip addr add 128.8.37.119/27 brd + dev enp4s2
sudo ip addr add 128.8.238.93/26 brd + dev enp4s2
sudo ip addr add 128.8.37.112/27 brd + dev enp4s2
sudo ip link set dev enp4s2 up

lines=$(wc -l /etc/iproute2/rt_tables | cut -d " " -f 1)
if [ lines == 11 ]
then
echo "2 Gateway1" |sudo tee -a /etc/iproute2/rt_tables
echo "3 Gateway2" |sudo tee -a /etc/iproute2/rt_tables
fi

CONTROL=$(sudo lxc-info -n main_control -iH)
FILES=$(sudo lxc-info -n main_files -iH)
DATABASE=$(sudo lxc-info -n main_database -iH)
RESOURCES=$(sudo lxc-info -n main_resources -iH)

sudo ip route add default via 128.8.37.97 table 2
sudo ip route add default via 128.8.238.65 table 3


sudo ip rule add from $CONTROL table 2
sudo ip rule add from $FILES table 2
sudo ip rule add from $DATABASE table 3
sudo ip rule add from $RESOURCES table 2




