#!/bin/bash

#1. Collect the information from nohup in MITM
#2. Track changes within the system and output to directory, copy to host
#3. Copy directory with files uploaded with poisoned commands to host
#4. (****Using netdata to capture system health for ram container****)
#5. Run data collection script once a day (initially), and then zipping every week (separate script from data collection)

#Variables 
control_container=$1
file_container=$2
db_container=$3
resources_container=$4
date=$(date '+%Y-%m-%d')

if [ $# - ne 4 ]
then
	echo “Usage: Provide the container names in the order of: control, file, db, and ram”
fi

# Copying nohup.out to MITM log directory on host
# Each MITM will be started in the container’s directory 
cp /$control_container/nohup.out /Logs/MITMLogs/$date_$control_container.log
cp /$file_container/nohup.out /Logs/MITMLogs/$date_$file_container.log 
cp /$db_container/nohup.out /Logs/MITMLogs/$date_$db_container.log 
cp /$resource_container/nohup.out /Logs/MITMLogs/$date_$resource_container.log 

# Copying the logins from the MITM server
cp /root/MITM_data/logins /Logs/$date_logins.txt

#Copying .downloads directory to host (poisoned commands)
mkdir /Logs/Poisoned_Commands/$date
cp -r /var/lib/lxc/$control_container/rootfs/var/log/.downloads /Logs/Poisoned_Commands/$date/$control_container.log
cp -r /var/lib/lxc/$file_container/rootfs/var/log/.downloads /Logs/Poisoned_Commands/$date/$file_container.log
cp -r /var/lib/lxc/$db_container/rootfs/var/log/.downloads	/Logs/Poisoned_Commands/$date/$db_container.log
cp -r /var/lib/lxc/$resources_container/rootfs/var/log/.downloads /Logs/Poisoned_Commands/$date/$resources_container.log

## Only tracking the new changes of the log files

# Comparing last full log with current full log and only showing lines unique to 
# Current full log, sets output to changes file 
comm -23 /Logs/MITMLogs/$date_$control_container.log /Logs/MITMLogs/last_full_log_control > /Logs/MITMLogs/$date_$control_container.log.changes 

cp /Logs/MITMLogs/$date_$control_container.log /Logs/MITMLogs/last_full_log_control
rm /Logs/MITMLogs/$date_$control_container.log
mv /Logs/MITMLogs/$date_$control_container.log.changes /Logs/MITMLogs/$date_$control_container.log

# Files
comm -23 /Logs/MITMLogs/$date_$files_container.log /Logs/MITMLogs/last_full_log_files > /Logs/MITMLogs/$date_$files_container.log.changes

cp /Logs/MITMLogs/$date_$file_container.log /Logs/MITMLogs/last_full_log_files
rm /Logs/MITMLogs/$date_$file_container.log
mv /Logs/MITMLogs/$date_$file_container.log.changes /Logs/MITMLogs/$date_$file_container.log

# Resources
comm -23 /Logs/MITMLogs/$date_$resources_container.log /Logs/MITMLogs/last_full_log_resources > /Logs/MITMLogs/$date_$resources_container.log.changes

cp /Logs/MITMLogs/$date_$resources_container.log /Logs/MITMLogs/last_full_log_resources
rm /Logs/MITMLogs/$date_$resources_container.log
mv /Logs/MITMLogs/$date_$resources_container.log.changes /Logs/MITMLogs/$date_$resources_container.log

# Database
comm -23 /Logs/MITMLogs/$date_$db_container.log /Logs/MITMLogs/last_full_log_db > /Logs/MITMLogs/$date_$db_container.log.changes

cp /Logs/MITMLogs/$date_$db_container.log /Logs/MITMLogs/last_full_log_db
rm /Logs/MITMLogs/$date_$db_container.log
mv /Logs/MITMLogs/$date_$db_container.log.changes /Logs/MITMLogs/$date_$db_container.log
 


 

