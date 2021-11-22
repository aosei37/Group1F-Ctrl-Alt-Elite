#!/bin/bash

#should run after data collection

sudo killall node
sleep 3
sudo rm /home/student/control_template/nohup.out
sudo rm /home/student/file_template/nohup.out
sudo rm /home/student/database_template/nohup.out
sudo rm /home/student/resources_template/nohup.out


/bin/bash /home/student/control_template/setup > /home/student/control_template/nohup.out
/bin/bash /home/student/file_template/setup > /home/student/file_template/nohup.out
/bin/bash /home/student/database_template/setup > /home/student/database_template/nohup.out
/bin/bash /home/student/resources_template/setup > /home/student/resources_template/nohup.out
