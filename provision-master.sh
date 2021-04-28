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


echo "Checking Terraform"
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


echo "Checking AWS client"
if ! command -v aws > /dev/null; then

	# install prerequisites for terraform installation
	if ! command -v curl > /dev/null; then
		echo "installing curl for aws"
		sudo apt install -y curl;
	fi
	if ! command -v unzip > /dev/null; then
		echo "installing unzip for aws"
		sudo apt install -y unzip;
	fi
	echo "installing aws client"

	path=$(pwd); cd /tmp;
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip";
	unzip awscliv2.zip && sudo ./aws/install;
	cd $path;

	echo "please configure your AWS"
	aws configure;

else
	echo "AWS is already installed for current user";
fi





