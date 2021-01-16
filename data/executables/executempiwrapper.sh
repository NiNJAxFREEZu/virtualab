#!/bin/bash
# UI wrapper for MPI module
echo "-------------"
echo "VirtuaLab MPI"
echo "-------------"

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