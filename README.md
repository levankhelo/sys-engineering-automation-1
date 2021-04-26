# chapter-6.1
Big Data - DevOps training chapter 6
<hr>

# task 1  

First things first! let's update our repositories and see what packages we have!  

```bash
apt-get update;
```  

## Step 1: Installing *Ansible*  

**Using apt**  

*Install for all users*
```bash
sudo apt-get install -y ansible;
```  
or  
*Install for single user*  
```bash
sudo apt install -y ansible;
```  

**Using source**  
use this method, if above one fails
```bash
sudo apt-get install -y git;
git clone git://github.com/ansible/ansible.git && cd ./ansible;
source ./hacking/env-setup;
```  
> Note: you will have access to ansible commands only from terminal tabs/windows, that are sourcing *ansible's* `hacking/env-setup`  
**Check Ansible installation**

```bash
if command -v ansible &> /dev/null; then echo "ansible successfully installed"; else echo "failed to install ansible"; fi
```


## Step 2: Installing *Packer*  

**Using apt**  

*Install for all users*
```bash
sudo apt-get install -y packer
```  
or  
*Install for single user*
```bash
sudo apt install -y packer
```  

**Using repo**  
use this if above installation fails  

*Emergency instllation for all users**
```bash
sudo apt-get install -y curl;
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -;
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main";
sudo apt-get update && sudo apt-get install packer;
```  

*Emergency instllation for current user**
```bash
sudo apt install -y curl;
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -;
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main";
sudo apt-get update && sudo apt install packer;
```  


**Check Packer installation**

```bash
if command -v packer &> /dev/null; then echo "packer successfully installed"; else echo "failed to install packer"; fi
```


## Step 3: Installing *Terraform*

```bash
sudo apt-get install -y unzip;
wget https://releases.hashicorp.com/terraform/0.15.0/terraform_0.15.0_linux_amd64.zip;
unzip terraform*.zip;
sudo mv terraform /usr/local/bin;
rm terraform*.zip; 
```
> - Note: Version of Terraform might be different! look for correct version [here](https://www.terraform.io/downloads.html)

**Check Terraform installation**

```bash
if command -v terraform &> /dev/null; then echo "terraform successfully installed"; else echo "failed to install terraform"; fi
```