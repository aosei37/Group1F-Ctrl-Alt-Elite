#!/bin/bash

previous_date=$(date -d "$date -1 days" +"%Y-%m-%d")
file_name="*$previous_date*"
name_to_remove="*${previous_date}_main*"

cd /home/student/Logs/MITMLogs
sudo zip -r $previous_date.zip $file_name
sudo rm /home/student/Logs/MITMLogs/$name_to_remove
