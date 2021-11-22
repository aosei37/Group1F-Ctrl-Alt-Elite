#!/bin/bash
if [ $# -ne 1 ]
then
echo "One argument, name of container"
exit 1
fi
sudo mkdir /var/lib/lxc/$1/rootfs/var/log/.downloads
sudo lxc-attach -n $1 -- bash -c 'echo -e "Y\n" | sudo apt-get install wget'
sudo lxc-attach -n $1 -- bash -c 'echo -e "Y\n" | sudo apt-get install curl'
#wget: assumes fake_wget is already executable
mv /var/lib/lxc/$1/rootfs/usr/bin/wget /var/lib/lxc/$1/rootfs/usr/bin/wget.orig
cp fake_wget /var/lib/lxc/$1/rootfs/usr/bin/wget
#curl: assumes fake_curl is already executable
mv /var/lib/lxc/$1/rootfs/usr/bin/curl /var/lib/lxc/$1/rootfs/usr/bin/curl.orig
cp fake_curl /var/lib/lxc/$1/rootfs/usr/bin/curl
