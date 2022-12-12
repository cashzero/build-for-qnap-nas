#!/bin/bash

GIT_VERSION="2.23.0"

apt-get update
apt-get install -y gcc wget make libcurl4-openssl-dev libexpat1-dev gettext libssl-dev zlib1g-dev
#yum install -y gcc wget make curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel

cd ~
if [ ! -f git-${GIT_VERSION}.tar.gz ]; then
    wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz
fi
if [ -d git-${GIT_VERSION} ]; then
    rm -rf git-${GIT_VERSION}
fi
tar zxvf git-${GIT_VERSION}.tar.gz
cd git-${GIT_VERSION}; ./configure --prefix=/share/Public/toolchain/
make all
make install
