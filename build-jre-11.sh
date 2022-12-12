#!bin/bash

JDK_VERSION="jdk-11+28"

apt-get update
apt-get install -y autoconf make unzip zip build-essential software-properties-common
apt-get install -y libx11-dev libxext-dev libxrender-dev libxtst-dev libxt-dev libcups2-dev libfontconfig1-dev libasound2-dev
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get install -y install openjdk-11-jdk

cd ~
wget https://github.com/openjdk/jdk/archive/refs/tags/$JDK_VERSION.zip
#git clone https://github.com/openjdk/jdk.git

unzip $JDK_VERSION.zip
cd jdk-jdk-11-28
bash configure --prefix=/share/Public/toolchain
make -j
make install
