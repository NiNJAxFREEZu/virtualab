#!/bin/sh

apt install python git libnotify-bin
mkdir $HOME/.virt-lab-modules
git clone https://github.com/wranidlo/broadcast_sender_receiver $HOME/.virt-lab-modules
