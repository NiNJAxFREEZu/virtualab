#!/bin/bash
# UI wrapper for MPI module
echo -e "___    _______         _____                 ______         ______         ______  ___________ ________
__ |  / /___(_)__________  /_____  ________ ____  / ______ ____  /_        ___   |/  /___  __ \____  _/
__ | / / __  / __  ___/_  __/_  / / /_  __ `/__  /  _  __ `/__  __ \       __  /|_/ / __  /_/ / __  /
__ |/ /  _  /  _  /    / /_  / /_/ / / /_/ / _  /___/ /_/ / _  /_/ /       _  /  / /  _  ____/ __/ /
_____/   /_/   /_/     \__/  \__,_/  \__,_/  /_____/\__,_/  /_.___/        /_/  /_/   /_/      /___/
                                                                                                       \n\n"

echo "What's the path to the C source file?"
read cpath

echo "Where to store the output?"
read opath

echo "How many nodes should be used for processing?"
read numnodes

sudo /mirror/./executempi.sh $cpath $opath $numnodes
cat $opath

echo "Press any key to exit..."
read key
exit 0