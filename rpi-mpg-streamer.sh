#!/bin/bash -ex

#check for root
LUID=$(id -u)
if [[ $LUID -ne 0 ]]; then
	echo "$0 must be run as root"
	exit 1
fi


# Install function
install ()
{
	apt-get update
	DEBIAN_FRONTEND=noninteractive apt-get -y \
	-o DPkg::Options::=--force-confdef \
	-o DPkg::Options::=--force-confold \
	install $@
}

#install packages from repositories using function
install build-essential \
	subversion \
	libjpeg-dev

#Checkout mjpg-streamer to /tmp/mjpg-streamer/
svn co https://mjpg-streamer.svn.sourceforge.net/svnroot/mjpg-streamer /tmp/mjpg-streamer

#Compile mjpg-streamer
cd /tmp/mjpg-streamer/mjpg-streamer/ && make && make install

