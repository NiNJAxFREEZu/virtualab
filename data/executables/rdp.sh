#!/bin/bash
# Script configures RDP server
# sudo apt-get -y install xrdp
sudo ufw allow 3389/tcp
sudo /etc/init.d/xrdp restart
