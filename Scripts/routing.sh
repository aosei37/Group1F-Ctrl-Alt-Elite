#!/bin/bash



sysctl -w net.ipv4.ip_forward=1

sudo ip addr add 128.8.37.114/27 brd + dev enp4s2
sudo ip addr add 128.8.37.119/27 brd + dev enp4s2
sudo ip addr add 128.8.238.93/26 brd + dev enp4s2
sudo ip addr add 128.8.37.112/27 brd + dev enp4s2
sudo ip link set dev enp4s2 up

VAR=$(sudo grep /etc/iproute2/rt_tables "Gateway1")
if [ -z "$VAR" ]
then
echo "2 Gateway1" |sudo tee -a /etc/iproute2/rt_tables
echo "3 Gateway2" |sudo tee -a /etc/iproute2/rt_tables
fi

CONTROL=$(sudo lxc-info -n main_control -iH)
control_ext_ip=$(sudo iptables -L -v -n -t nat | grep $CONTROL | tail -n 1 | cut -d ":" -f 2 | grep 238)

RESOURCES=$(sudo lxc-info -n main_resources -iH)
resources_ext_ip=$(sudo iptables -L -v -n -t nat | grep $RESOURCES | tail -n 1 | cut -d ":" -f 2 | grep 238)

DATABASE=$(sudo lxc-info -n main_database -iH)
db_ext_ip=$(sudo iptables -L -v -n -t nat | grep $DATABASE | tail -n 1 | cut -d ":" -f 2 | grep 238)

FILES=$(sudo lxc-info -n main_files -iH)
files_ext_ip=$(sudo iptables -L -v -n -t nat | grep $FILES | tail -n 1 | cut -d ":" -f 2 | grep 238)


sudo ip route add default via 128.8.37.97 table 2
sudo ip route add default via 128.8.238.65 table 3


if [ -z "$control_ext_ip" ]
then
	sudo ip rule add from $CONTROL table 2
else
	sudo ip rule add from $CONTROL table 3
fi

if [ -z "$resources_ext_ip" ]
then
        sudo ip rule add from $RESOURCES table 2
else
        sudo ip rule add from $RESOURCES table 3
fi

if [ -z "$database_ext_ip" ]
then
        sudo ip rule add from $DATABASE table 2
else
        sudo ip rule add from $DATABASE table 3
fi

if [ -z "$files_ext_ip" ]
then
        sudo ip rule add from $FILES table 2
else
        sudo ip rule add from $FILES table 3
fi


