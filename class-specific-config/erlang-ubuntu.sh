#!/bin/sh

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update --yes
sudo apt-get install esl-erlang --yes

echo "Programowanie wieloparadygmatowe - środowisko zostało skonfigurowane!"
