#!/bin/bash
if [ $1 = "student" ]; then
  su vagrant
  chmod +x /home/vagrant/data/install.sh
  bash /home/vagrant/data/install.sh student
  cp /home/vagrant/data/.xsession /home/vagrant/
fi

if [ $1 = "professor" ]; then
  su vagrant
  chmod +x /home/vagrant/data/install.sh
  bash /home/vagrant/data/install.sh professor
  cp /home/vagrant/data/.xsession /home/vagrant/
fi