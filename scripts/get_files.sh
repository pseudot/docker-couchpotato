#!/bin/bash
if [ ! -z "$1" ]; then
  LOC=$1
  LOC2=$LOC1
else 
  LOC=/tmp
  LOC2=/opt
fi

# Get setuptools
echo Downloading setuptools
if [ ! -d "$LOC/python" ]; then
  mkdir $LOC/python
fi
wget https://bootstrap.pypa.io/ez_setup.py --no-check-certificate -O $LOC/python/ez_setup.py -nv 

#Rar
echo Downloading RAR
if [ ! -d "$LOC/os" ]; then
  mkdir $LOC/os
fi
wget http://www.rarlab.com/rar/rarlinux-x64-4.1.1.tar.gz -O $LOC/os/rar.tar.gz -nv
mkdir /tmp/rar.tar.gz
tar -zxf $LOC/os/rar.tar.gz -C /tmp/rar.tar.gz

echo Cloning couchpotato repo
if [ -d "$LOC2/couchpotato" ]; then
  rm -rf $LOC2/couchpotato
fi
mkdir $LOC2/couchpotato
git clone -b master https://github.com/RuudBurger/CouchPotatoServer.git  $LOC2/couchpotato
