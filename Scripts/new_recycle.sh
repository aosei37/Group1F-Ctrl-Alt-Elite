#!/bin/bash
CREATE_PATH=/home/student/Group1F-Ctrl-Alt-Elite/Scripts/create.sh
RESULTS_PATH=/home/student/Logs/Recycling_Results/
HOST_NAME=/home/student/Group1F-Ctrl-Alt-Elite/Scripts/hostname.sh
MEMORY_PATH=/home/student/Group1F-Ctrl-Alt-Elite/Scripts/memory-modifier.sh
MITM_PATH=/home/student/Group1F-Ctrl-Alt-Elite/Scripts/mitm_setup.sh
ROUTING_PATH=/home/student/Group1F-Ctrl-Alt-Elite/Scripts/routing.sh
date=`date "+%H:%M-%Y-%m-%d"`

echo -e "------------------------------------------------\n" >> $RESULTS_PATH/$date.results.txt
echo "Recycle Date: $(date)" >> $RESULTS_PATH/$date.results.txt
echo "Starting to recycle containers: main_control, main_files, main_database, main_resources...." >> $RESULTS_PATH/$date.results.txt

# Destroys all containers 
lxc-stop -n "main_control"
lxc-stop -n "main_files"
lxc-stop -n "main_database"
lxc-stop -n "main_resources"
lxc-destroy -n "main_control"
lxc-destroy -n "main_files"
lxc-destroy -n "main_database"
lxc-destroy -n "main_resources"
echo "All containers have been stopped and destroyed..." >> $RESULTS_PATH/$date.results.txt

#Flushing the iptables and re-adding the blacklist to the rules
#sudo ipset save blacklist -f /home/student/Backup/ipset-blacklist.backup
sudo iptables -F -t nat
#sudo iptables -I INPUT -m set --match-set blacklist src -j DROP
#sudo iptables -I FORWARD -m set --match-set blacklist src -j DROP
#sudo ipset restore -! < /home/student/Backup/ipset-blacklist.backup

arr=('128.8.37.114' '128.8.37.119' '128.8.238.93' '128.8.37.112')
arr=( $(shuf -e "${arr[@]}") )
arr2=('27' '27' '27' '27')
for i in "${!arr[@]}"; do
    if [[ ${arr[$i]} == "128.8.238.93" ]]; then
        arr2[$i]="26"
    fi
done
## All template containers need to be stopped first ##
# Recreates each container with the IP rules
$CREATE_PATH main_control ${arr[0]} ${arr2[0]}
echo "Main control container has been recreated with it's corresponding IP table Rules..." >> $RESULTS_PATH/$date.results.txt

$CREATE_PATH main_files ${arr[1]} ${arr2[1]}
echo "Main files container has been recreated with it's corresponding IP table Rules..." >> $RESULTS_PATH/$date.results.txt

$CREATE_PATH main_database ${arr[2]} ${arr2[2]}
echo "Main database container has been recreated with it's corresponding IP table Rules..." >> $RESULTS_PATH/$date.results.txt

$CREATE_PATH main_resources ${arr[3]} ${arr2[3]}
echo "Main resources container has been recreated with it's corresponding IP table Rules..." >> $RESULTS_PATH/$date.results.txt
echo "All containers have been destroyed and recreated!" >> $RESULTS_PATH/$date.results.txt

# Changing the hostname of all the containers
$HOST_NAME main_control mycomputer
$HOST_NAME main_files katra@retail
$HOST_NAME main_database katra_records
$HOST_NAME main_resources computer
echo "Host names have been changed for all containers..." >> $RESULTS_PATH/$date.results.txt

# This has to be run after hostname as restarting the container resets the memory
$MEMORY_PATH main_control main_files main_database
echo "Memory has been modified for main_control, and main_files, and main_database..." >> $RESULTS_PATH/$date.results.txt                                   
echo "All containers have been destroyed and recreated!" >> $RESULTS_PATH/$date.results.txt
echo -e "------------------------------------------------\n\n" >> $RESULTS_PATH/$date.results.txt

# Adding the .downloads folder to all containers for poisoned commands
sudo mkdir /var/lib/lxc/main_control/rootfs/var/log/.downloads
chmod ugo+w /var/lib/lxc/main_control/rootfs/var/log/.downloads
sudo mkdir /var/lib/lxc/main_files/rootfs/var/log/.downloads
chmod ugo+w /var/lib/lxc/main_files/rootfs/var/log/.downloads
sudo mkdir /var/lib/lxc/main_database/rootfs/var/log/.downloads
chmod ugo+w /var/lib/lxc/main_database/rootfs/var/log/.downloads
sudo mkdir /var/lib/lxc/main_resources/rootfs/var/log/.downloads
chmod ugo+w /var/lib/lxc/main_resources/rootfs/var/log/.downloads

# adding poisoned commands to control 
sudo lxc-attach -n main_control -- echo -e "y\n" | sudo lxc-attach -n main_control sudo apt install curl 
sudo lxc-attach -n main_control -- sudo apt install wget 
sudo cp /var/lib/lxc/main_control/rootfs/bin/curl /var/lib/lxc/main_control/rootfs/bin/curlOld
sudo cp /var/lib/lxc/main_control/rootfs/bin/wget /var/lib/lxc/main_control/rootfs/bin/wgetOld
sudo rm /var/lib/lxc/main_control/rootfs/bin/curl
sudo rm /var/lib/lxc/main_control/rootfs/bin/wget
sudo cp /bin/wgetTemp /var/lib/lxc/main_control/rootfs/bin/wget
sudo cp /bin/curlTemp /var/lib/lxc/main_control/rootfs/bin/curl
sudo chmod a+x /var/lib/lxc/main_control/rootfs/bin/curl
sudo chmod a+x /var/lib/lxc/main_control/rootfs/bin/wget

# adding poisoned commands to files
sudo lxc-attach -n main_files -- echo -e "y\n" | sudo lxc-attach -n main_files sudo apt install curl
sudo lxc-attach -n main_files -- sudo apt install wget
sudo cp /var/lib/lxc/main_files/rootfs/bin/curl /var/lib/lxc/main_files/rootfs/bin/curlOld
sudo cp /var/lib/lxc/main_files/rootfs/bin/wget /var/lib/lxc/main_files/rootfs/bin/wgetOld
sudo rm /var/lib/lxc/main_files/rootfs/bin/curl
sudo rm /var/lib/lxc/main_files/rootfs/bin/wget
sudo cp /bin/wgetTemp /var/lib/lxc/main_files/rootfs/bin/wget
sudo cp /bin/curlTemp /var/lib/lxc/main_files/rootfs/bin/curl
sudo chmod a+x /var/lib/lxc/main_files/rootfs/bin/curl
sudo chmod a+x /var/lib/lxc/main_files/rootfs/bin/wget

# adding poisoned commands to resources
sudo lxc-attach -n main_resources -- echo -e "y\n" | sudo lxc-attach -n main_resources sudo apt install curl
sudo lxc-attach -n main_resources -- sudo apt install wget
sudo cp /var/lib/lxc/main_resources/rootfs/bin/curl /var/lib/lxc/main_resources/rootfs/bin/curlOld
sudo cp /var/lib/lxc/main_resources/rootfs/bin/wget /var/lib/lxc/main_resources/rootfs/bin/wgetOld
sudo rm /var/lib/lxc/main_resources/rootfs/bin/curl
sudo rm /var/lib/lxc/main_resources/rootfs/bin/wget
sudo cp /bin/wgetTemp /var/lib/lxc/main_resources/rootfs/bin/wget
sudo cp /bin/curlTemp /var/lib/lxc/main_resources/rootfs/bin/curl
sudo chmod a+x /var/lib/lxc/main_resources/rootfs/bin/curl
sudo chmod a+x /var/lib/lxc/main_resources/rootfs/bin/wget

# adding poisoned commands to databases
sudo lxc-attach -n main_database -- echo -e "y\n" | sudo lxc-attach -n main_database sudo apt install curl
sudo lxc-attach -n main_database -- sudo apt install wget
sudo cp /var/lib/lxc/main_database/rootfs/bin/curl /var/lib/lxc/main_database/rootfs/bin/curlOld
sudo cp /var/lib/lxc/main_database/rootfs/bin/wget /var/lib/lxc/main_database/rootfs/bin/wgetOld
sudo rm /var/lib/lxc/main_database/rootfs/bin/curl
sudo rm /var/lib/lxc/main_database/rootfs/bin/wget
sudo cp /bin/wgetTemp /var/lib/lxc/main_database/rootfs/bin/wget
sudo cp /bin/curlTemp /var/lib/lxc/main_database/rootfs/bin/curl
sudo chmod a+x /var/lib/lxc/main_database/rootfs/bin/curl
sudo chmod a+x /var/lib/lxc/main_database/rootfs/bin/wget

# Restarting the MITM
$MITM_PATH
$ROUTING_PATH
