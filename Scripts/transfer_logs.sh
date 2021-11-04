#!/bin/bash

previous_date=$(date -d "$date -1 days" +"%Y-%m-%d")

sudo scp $previous_date.zip student@172.30.137.139:/home/student/Logs_From_Host
