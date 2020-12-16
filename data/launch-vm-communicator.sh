#!/bin/bash
su vagrant
export DISPLAY=:0.0
export XAUTHORITY=/home/vagrant/.Xauthority
python3 /etc/virtualab/vm-communicator/student_main.py