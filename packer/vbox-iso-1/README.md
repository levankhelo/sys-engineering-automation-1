# Execution results

Commands have been executed on device, where VirtualBox was installed, so we could use `VBoxManager` module for `Packer`

## Important note:

After Importing VDI into Virtualbox, if you will be put in `UEFI` mode, you should run following command:  
```shell
fs0:\efi\ubuntu\grubx64.efi
```

## Command

### Build vdi image
```bash
packer build vbox-iso.pkr.hcl
```

## Results from VDI
  
Following commands are executed in provisioned virtual box image (built with packer) and results are provided as proof of successfull installation of LEMP stack.  

LEMP stack includes:  
- Linux
- NginX (*Engine-X*)
- MySQL
- PHP

### Linux

![Results](https://github.com/levankhelo/chapter-6.1/blob/main/packer/vbox-iso-1/artifacts/linux-1.png?raw=true)

![Results](https://github.com/levankhelo/chapter-6.1/blob/main/packer/vbox-iso-1/artifacts/linux-2.png?raw=true)

![Results](https://github.com/levankhelo/chapter-6.1/blob/main/packer/vbox-iso-1/artifacts/linux-3.png?raw=true)

### Nginx (EnginX)

![Results](https://github.com/levankhelo/chapter-6.1/blob/main/packer/vbox-iso-1/artifacts/nginx.png?raw=true)

### MySql

![Results](https://github.com/levankhelo/chapter-6.1/blob/main/packer/vbox-iso-1/artifacts/mysql.png?raw=true)

### PHP

![Results](https://github.com/levankhelo/chapter-6.1/blob/main/packer/vbox-iso-1/artifacts/php.png?raw=true)


