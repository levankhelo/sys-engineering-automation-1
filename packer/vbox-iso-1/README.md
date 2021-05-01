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
  
Following commands are executed in provisioned virtual box image (built with packer) and results are provided as proof of successfull installation of LEMP

### php


