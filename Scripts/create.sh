#!/bin/bash

if [ $# -lt 3 ]
then
    echo "Provide the name, external IP address, and external network mask as agruments"
    exit 1
fi

if [[ ! `sudo lxc-ls | grep $1` ]]
then
      sudo ip addr add $2/$3 dev enp4s1

      if [[ $1 == "main_files" ]]
      then
          sudo lxc-copy -n files_template -N $1
      elif [[ $1 == "main_database" ]]
      then
          sudo lxc-copy -n database_template -N $1
      elif [[ $1 == "main_resources" ]]
      then
           sudo lxc-copy -n resources_template -N $1
      else
          sudo lxc-copy -n control_template -N $1
      fi

      sudo lxc-start -n $1
      sleep 8
      ip=`sudo lxc-info -n $1 -iH`

      sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination $2 --jump DNAT --to-destination $ip
      sudo iptables --table nat --insert POSTROUTING --source $ip --destination 0.0.0.0/0 --jump SNAT --to-source $2

      sleep 5

      sudo lxc-attach -n $1 -- sudo apt-get install openssh-server -y
      sudo lxc-attach -n $1 -- sudo apt-get install htop -y

elif [[ `sudo lxc-ls | grep $1` ]]
then
    sudo ip addr delete $2/$3 dev enp4s1
    sudo iptables --table nat --delete PREROUTING --source 0.0.0.0/0 -- destination $2 -- jump DNAT --to-destination $ip
    sudo iptables --table nat --delete POSTROUTING --source $ip --destination 0.0.0.0/0 --jump SNAT --to-source $2
    sudo lxc-stop -n $1
    sudo lxc-destroy -n $1
fi
