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





# Actions

## General

### Setup
in current state, we have few VirtualBox instances  
1 **Master** and few **Slave**.  
On VirtualBox we have shared network that we created from virtual box's settings
> *FIle* -> *Host Network Manager* settings
> Add network mode *Host* to all virtual box instances so they will be on same, shared network.

In my case, VirualBox's network is `192.168.56.100`.  
It means that each device i add, will be adding up at the end like: `192.168.56.101`, `192.168.56.102`, `192.168.56.103` and so on.  

In this example, `192.168.56.101` is Master device when `192.168.56.102` and `192.168.56.103` are slave devices.

> note: if you don't know exact ip address of your slave devices run `ip a` command and look for something like `192.168.***.***` where `*` can be any number. or look for ip address under `enp0s*`, where `*` is any number, after running `ip a`

### Generate ssh-keys for connection

Run following command only on *Master* device:
```bash
ssh-keygen
```
and keep clicking enter on all prompts.


### Copy ssh public key for passwordless connection

Run following command on Master device:
```bash
ssh-copy-id slave@192.168.56.102
```
> Note: provide password when asked
```
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
slave@192.168.56.102's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'slave@192.168.56.102'"
and check to make sure that only the key(s) you wanted were added.
```

**Important**: Repeat this process (`ssh-copy-id`) for each slave device!
> Note: for all non-master ip's that we are going to control
