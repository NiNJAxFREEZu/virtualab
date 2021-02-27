# VirtuaLab
System for conducting remote classes using virtual machines.

# How it works?
VirtuaLab sets up a cluster of virtual machines running custom Ubuntu image in a bridged network. These machines come with additional utilities such as text chat, activity monitor, attendance check and integrated MPI computing module. Additionaly, each virtual machine can be accessed via RDP client thanks to preinstaled RDP server.

## System requirements:
- OS: *Windows* or *GNU/Linux* (*OSX* is to be tested)
- *Python* language support
- *dos2unix* (if you run Windows systems)
- *Vagrant*
- *VirtualBox*
- Minimum of 1 core and 1GiB of RAM for each virtual machine is recomended for optimal performance.

## How to run?
```bash
$ python virtualab.py [COMMAND] {OPTIONS}
```
Issue ```python virtualab.py help``` for available commands.
