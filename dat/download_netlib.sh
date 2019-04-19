#!/bin/bash

# Download and extract Netlib testset in .SIF format
wget ftp://ftp.numerical.rl.ac.uk/pub/cuter/netlib.tar.gz
gunzip netlib.tar.gz
tar -xf netlib.tar

# Move non-instance files
mv netlib/netlib.html netlib.html
mv netlib/NETLIB.dat NETLIB.dat
rm netlib/NETLIB.dat~
mv netlib/README ./netlib_readme.txt
