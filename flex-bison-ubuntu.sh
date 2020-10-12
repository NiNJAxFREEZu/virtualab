#!/bin/sh

sudo apt-get update --yes
sudo apt-get install flex
wget http://ftp.gnu.org/gnu/bison/bison-3.4.tar.gz
tar -zxvf bison-3.4.tar.gz
cd bison-3.4/
sudo ./configure
sudo make
sudo make install

echo "Flex i Bison - środowisko zostało skonfigurowane!"
