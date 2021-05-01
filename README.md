
# chapter-6

Big Data - DevOps training chapter 6

# Installations

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
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install Packer
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
>
> Note: Version of Terraform might be different! look for correct version [here](https://www.terraform.io/downloads.html)

**Check Terraform installation**

```bash
if command -v terraform &> /dev/null; then echo "terraform successfully installed"; else echo "failed to install terraform"; fi
```

# Summary

All steps from **Installations** are wrapped up in `provision-master.sh` file in current repository  

# Environment & Connections

## General

### Setup

in current state, we have few VirtualBox instances  
1 **Master** and few **Slave**.  
username of **Slave** devices should be **SAME**!  
on slave devices, we need to install and setup `openssh-server`. see `provision-slave.sh` script.  
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

```text
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
slave@192.168.56.102's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'slave@192.168.56.102'"
and check to make sure that only the key(s) you wanted were added.
```

**Important**: Repeat this process (`ssh-copy-id`) for each slave device!
> Note: for all non-master ip's that we are going to control

# Ansible  

## Configuration

Now that everything is set up, you can go in `/etc/ansible/hosts` file as `root` and add your *slave* device ip addresses
> note: you can use `sudo nano /etc/ansible/hosts`

After appending slave ip addresses, your `/etc/ansible/hosts` should look like this
> Note: it may be different, based on where you have added ip addresses. In this case, we ate adding them at the top

```bash
192.168.56.102 
192.168.56.104 
# more ip adresses


# This is the default ansible 'hosts' file.
#
# It should live in /etc/ansible/hosts
#
#   - Comments begin with the '#' character
...
```

> Note: remember that ip adresses can be different in your case


## naming slave nodes  

Again, in `/etc/ansible/hosts` we should change our configuration to following

```bash
slave1 ansible_ssh_host=192.168.56.102 ansible_ssh_user=slave
slave2 ansible_ssh_host=192.168.56.104 ansible_ssh_user=slave
# more configurations


# This is the default ansible 'hosts' file.
#
# It should live in /etc/ansible/hosts
#
#   - Comments begin with the '#' character
...
```

where `slave1` and `slave2` are names of nodes. you can name them anything!  
`ansible_ssh_host` is variable that stores ip address of node as value.  
`ansible_ssh_user` is variable that stores `username` of target node.  

now we can execute all command by replacing `all` to `slave-name`, for example  

```bash
ansible -m shell -a 'uname -a' slave1
```
> note: you can find more modules and commands below

## Commands

Make sure that you configured your configuration file correctly.  
Now let's send command to all devices together!  

Run following command:  

```bash
ansible -u slave -m ping all
```

> This will check if everything is configured correctly  
> Note: after `-u` tag, you can inout `username` of your `slave` devices, instead of `slave`.  
> Note: if you used additional configuration with usernames, you do not need to use `-u` tag

If you get green output, it means everything went Great! if you see red output, it means something went wrong for that particular device.  
Make sure that device is running with `sshd` service and `ssh` ports are enabled on device.  

when that command succeds, you can use other modules of ansible like:  

### Command: shell - Execute a command on slave devices

```bash  
ansible -m shell -a 'uname -a' all
```
>
> you can use command you want instead of `'uname -a'`, after `-a` argument

### Command: copy - Copy file from slave devices

```bash
ansible -m copy -a 'src=/etc/motd dest=/tmp/' slave1
```

### Comand: setup - Described information about slave device

```bash
ansible -m setup slave2
```

## Grouping devices

Create new file wherever you want.
This file will be used for additional ansible configuration.  
In our case, we are creating file in `/etc/ansible` and naming it `host-config`

In `/etc/ansible/host-config` we should add ip adresses we want to group (in one in separate groups) and add group tag at the top

```bash

[ubuntu]
slave1 ansible_ssh_host=192.168.56.102 ansible_ssh_user=slave
slave2 ansible_ssh_host=192.168.56.104 ansible_ssh_user=slave

# [mint]
# my mint devices here

# [mygroup]
# my device configurations here


[linux]
ubuntu
# all other group names

```

In the configuration above, you can see that we grouped `slave1` and `slave2` in group `ubuntu`, because they are ubuntu based devices.  
You can name groups whatever you want, so it could be `mygroup` if we wanted.  
Afterwards, we added our `ubuntu` group in parent, `linux` group.  
  
This type of configuration, gives us adventage of manipulating devices by their type, or by service they provide.  
After grouping devices, we can use this names in commands like this:  

```bash
ansible -i /etc/ansible/host-config -m ping linux;
ansible -i /etc/ansible/host-config -m ping ubuntu;
ansible -i /etc/ansible/host-config -m ping slave1;
```

> Note: you would see that we added `-i` tag ther refferes to configuration file  

Now we can use group names instead of device names.  
So we can use `linux` to refer to all `ubuntu` devices or we can use `ubuntu` to refer all `slave1` and `slave2` devices.  

