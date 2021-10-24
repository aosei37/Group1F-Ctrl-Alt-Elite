#!/bin/bash
if [ $# -ne 4 ]
then
        echo "Usage: Four arguments in order of control, file d
atabase, resource."
fi

date=$(date '+%Y-%m-%d')
status=$(sudo lxc-ls -f | grep "main_control" | grep STOPPED)

if [ -z "$status" ]
then
        sudo lxc-attach -n "main_control" -- echo q | htop -C | aha --line-
fix | html2text -width 999 | grep -v "F1Help\|xml version=" > $
1_Health_$date.txt
else
        echo "main_control is Stopped" >> error_$date.txt
fi


status=$(sudo lxc-ls -f | grep "main_files" | grep STOPPED)
if [ -z "$status" ]
then
        sudo lxc-attach -n "main_files" -- echo q | htop -C | aha --line-
fix | html2text -width 999 | grep -v "F1Help\|xml version=" > $
2_Health_$date.txt
else
  echo "main_files is Stopped" >> error_$date.txt
fi

status=$(sudo lxc-ls -f | grep "main_database" | grep STOPPED)
if [ -z "$status" ]
then
        sudo lxc-attach -n "main_database" -- echo q | htop -C | aha --line-
fix | html2text -width 999 | grep -v "F1Help\|xml version=" > $
3_Health_$date.txt
else
        echo "main_database is Stopped" >> error_$date.txt
fi

status=$(sudo lxc-ls -f | grep "main_resources" | grep STOPPED)
if [ -z "$status" ]
then
        sudo lxc-attach -n "main_resources" -- echo q | htop -C | aha --line-
fix | html2text -width 999 | grep -v "F1Help\|xml version=" > $
4_Health_$date.txt
else
        echo "main_resources is Stopped" >> error_$date.txt
fi

#iptables-restore /root/working.iptables.rules
