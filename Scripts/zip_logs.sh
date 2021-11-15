#!/bin/bash

previous_date=$(date -d "$date -1 days" +"%Y-%m-%d")
file_name="*$previous_date*"
name_to_remove="*${previous_date}_main*"

sudo zip /home/student/Logs/MITMLogs/$previous_date.zip /home/student/Logs/MITMLogs/$file_name
sudo rm /home/student/Logs/MITMLogs/$name_to_remove
