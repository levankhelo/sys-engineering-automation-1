#!/bin/bash

sudo apt-get update > /dev/null;

echo "Checking openssh-Server";
if ! command -v sshd > /dev/null; then
	# install packer for current user
	
	echo "Installing openssh-server";
	sudo apt install -y openssh-server;
else
	echo "Openssh-server is installed";
fi

echo "Checking if firewall enables ssh connection";
if [[ $(sudo ufw show added | grep 22 | wc -l) -gt 0 ]]; then 
	echo "Enable ssh throught firewall";
	sudo ufw allow ssh;
	sudo systemctl restart sshd;
fi