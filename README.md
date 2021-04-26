# chapter-6.1
Big Data - DevOps training chapter 6
<hr><hr>  

# task 1  


```bash
apt-get update;
```  

### Installing ansible  

**Using apt**  

*Install for all users*
```bash
sudo apt-get install -y ansible;
```  

*Install for single user*  
```bash
sudo apt install -y ansible;
```  

**Using source**  
```bash
sudo apt-get install -y git;
git clone git://github.com/ansible/ansible.git && cd ./ansible;
source ./hacking/env-setup;
```  
> Note: you will have access to ansible commands only from terminal tabs/windows, that are sourcing *ansible's* `hacking/env-setup`  
**Check installation**

```bash
if command -v ansible &> /dev/null; then echo "ansible successfully installed"; else echo "failed to install ansible"; fi
```


### Installing Packer  

**Using apt**  

*Install for all users*
```bash
sudo apt-get install -y packer
```  

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


**Check installation**

```bash
if command -v packer &> /dev/null; then echo "packer successfully installed"; else echo "failed to install packer"; fi
```





```bash
if command -v terraform &> /dev/null; then echo "terraform successfully installed"; else echo "failed to install terraform"; fi
```