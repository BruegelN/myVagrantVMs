#!/bin/bash

# TODO: check if packages are already install and if so just skip
sudo apt-get update
# install a minimal lightweight DE
sudo apt-get install -y --no-install-recommends lubuntu-desktop
# install VirtualBox guest tools
sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
# configure VirtualBox guest tools
sudo VBoxClient --clipboard
sudo VBoxClient --draganddrop
sudo VBoxClient --display
sudo VBoxClient --checkhostversion
sudo VBoxClient --seamless
# how to set keyboard map to german (yz) ?
# OpenCV: compiler
sudo apt-get install -y build-essential
# OpenCV: required tools 
sudo apt-get install -y cmake git unzip pkg-config
# OpenCV: required libs 
sudo apt-get install -y libgtk2.0-dev libavcodec-dev libavformat-dev libswscale-dev
# OpenCV: optional libs
sudo apt-get install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

if [ ! -e /home/vagrant/opencv-3.2.0.zip ];then 
    # only download if not already there
    wget -O /home/vagrant/opencv-3.2.0.zip https://github.com/opencv/opencv/archive/3.2.0.zip
fi
unzip /home/vagrant/opencv-3.2.0.zip -d /home/vagrant

cd /home/vagrant/opencv-3.2.0
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D WITH_V4L=ON ..
make -j2
sudo make install

sudo /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig

