#!/bin/bash

sudo apt-get update > /dev/null;

echo "Checking Ansible"
if ! command -v ansible > /dev/null; then
	# install packer for current user
	
	echo "Installing Ansible";
	sudo apt install -y ansible;
fi



echo "Checking Packer"
if ! command -v packer > /dev/null; then
	# install packer for current user

	echo "Installing Packer";
	sudo apt install -y packer;
else
	echo "Packer is already installed for current user";
fi



if ! command -v terraform > /dev/null; then

	# install prerequisites for terraform installation
	if ! command -v wget > /dev/null; then
		echo "installing wget for terraform"
		sudo apt install -y wget;
	fi
	if ! command -v unzip > /dev/null; then
		echo "installing unzip for terraform"
		sudo apt install -y unzip;
	fi
	echo "installing terraform"

	# download terraform, unarchive and move to binary
	path=$(pwd); cd /tmp;
	wget https://releases.hashicorp.com/terraform/0.15.0/terraform_0.15.0_linux_amd64.zip;
	unzip terraform*.zip && sudo mv terraform /usr/local/bin && rm terraform*.zip; 
	cd $path;

else
	echo "Terraform is already installed for current user"
fi


