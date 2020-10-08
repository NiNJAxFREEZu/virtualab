#!/bin/sh

mkdir ~/domowy
sudo apt update --yes && sudo apt upgrade --yes
sudo apt install sshfs
sshfs -o StrictHostKeyChecking=no -o password_stdin $1@pcss-home.cloud:/ ~/domowy/ <<< $2

echo "Zamontowano dysk"
