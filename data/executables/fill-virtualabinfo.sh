#!/bin/bash
# This script changes #hostname tags in a given virtualab file into actual ipv4 addresses

# Getting all the hashtags!!!
 for hash in $(grep '#[a-Z]*[0-9]*' $1 -o)
 do
     hashless=$(echo ${hash} | sed "s/#//g")
     addr=$(cat /home/vagrant/data/ipaddress/$hashless)
     sed -i "s/${hash}/$addr/g" $1
 done
