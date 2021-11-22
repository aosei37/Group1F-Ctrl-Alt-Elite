#!/bin/bash

BLACKLISTED=/home/student/Backup/already_blocked.txt
TMP_RES=/home/student/Backup/res.ip
TMP_FILE=/home/student/Backup/files.ip
TMP_DB=/home/student/Backup/db.ip
TMP_CTRL=/home/student/Backup/ctrl.ip

# Getting the current list of logins 
sudo cat /root/MITM_data/logins/main_resources.txt | cut -d ";" -f2 | sort | uniq | sudo tee $TMP_RES > /dev/null 2>&1

sudo cat /root/MITM_data/logins/main_files.txt | cut -d ";" -f2 | sort | uniq | sudo tee $TMP_FILE > /dev/null 2>&1

sudo cat /root/MITM_data/logins/main_database.txt | cut -d ";" -f2 | sort | uniq | sudo tee $TMP_DB > /dev/null 2>&1

sudo cat /root/MITM_data/logins/main_control.txt | cut -d ";" -f2 | sort | uniq | sudo tee $TMP_CTRL > /dev/null 2>&1


# Loops through each file, and if the address was already not saved in the list, it adds it to the blacklist
while IFS= read -r line
do
	 sudo ipset test blacklist $line > /dev/null 2>&1
	 result=`echo $?`
	 if [ $result -ne 0 ]
	 then
		 sudo ipset add blacklist $line > /dev/null 2>&1
		 echo "$line" >> $BLACKLISTED
	 fi


done < "$TMP_FILE"


while IFS= read -r line
do
         sudo ipset test blacklist $line > /dev/null 2>&1
         result=`echo $?`
         if [ $result -ne 0 ]
         then
                 sudo ipset add blacklist $line > /dev/null 2>&1
		 echo "$line" >> $BLACKLISTED
         fi


done < "$TMP_DB"

while IFS= read -r line
do
         sudo ipset test blacklist $line > /dev/null 2>&1
         result=`echo $?`
         if [ $result -ne 0 ]
         then
                 sudo ipset add blacklist $line > /dev/null 2>&1
		 echo "$line" >> $BLACKLISTED
         fi


done < "$TMP_CTRL"

while IFS= read -r line
do
         sudo ipset test blacklist $line > /dev/null 2>&1
         result=`echo $?`
         if [ $result -ne 0 ]
         then
                 sudo ipset add blacklist $line > /dev/null 2>&1
		 echo "$line" >> $BLACKLISTED
         fi


done < "$TMP_RES"
