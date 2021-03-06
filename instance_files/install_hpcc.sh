#!/bin/bash

#install prereqs
sudo yum install -y boost141
sudo yum install -y compat-boost-regex

sudo yum install -y R-devel
sudo R CMD BATCH installR.r

. cfg_BestHPCC.sh

#install hpcc
mkdir hpcc
cd hpcc
echo "wget http://cdn.hpccsystems.com/releases/CE-Candidate-5.0.0/bin/platform/$hpcc_platform"
wget http://cdn.hpccsystems.com/releases/CE-Candidate-5.0.0/bin/platform/$hpcc_platform

echo "sudo rpm -iv --nodeps $hpcc_platform"
sudo rpm -iv --nodeps $hpcc_platform

#Has needs to pass in 'y' to confirm overwrite
#sudo /opt/HPCCSystems/sbin/keygen.sh

cd ..

#Install HTTPD passwd tool
sudo yum install -y httpd-tools

sudo htpasswd -cb /etc/HPCCSystems/.htpasswd hpcc S4LT

#Install s3
mkdir s3fs
cd s3fs
sudo wget http://s3fs.googlecode.com/files/s3fs-1.74.tar.gz
sudo tar xvf s3fs-1.74.tar.gz

sudo yum install -y fuse
sudo yum install -y fuse-devel
sudo yum install -y libcurl
sudo yum install -y libcurl-devel
sudo yum install -y openssl
sudo yum install -y openssl-devel
sudo yum install -y libxml2
sudo yum install -y libxml2-devel

cd s3fs-1.74
sudo ./configure  --prefix=/usr
sudo make
sudo make install

cd ~;
