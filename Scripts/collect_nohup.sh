#!/bin/bash

#sudo rm *.control.logs
#sudo rm *.files.logs
#sudo rm *.database.logs
#sudo rm *.resources.logs


tail -fn 0 /home/student/control_template/nohup.out >> /home/student/Logs/MITMLogs/`date "+\%Y-\%m-\%d"`.control.logs

tail -fn 0 /home/student/file_template/nohup.out >> /home/student/Logs/MITMLogs/`date "+\%Y-\%m-\%d"`.files.logs

tail -fn 0 /home/student/database_template/nohup.out >> /home/student/Logs/MITMLogs/`date "+\%Y-\%m-\%d"`.database.logs
tail -fn 0 /home/student/resources_template/nohup.out >> /home/student/Logs/MITMLogs/`date "+\%Y-\%m-\%d"`.resources.logs

echo "Started collecting!"
