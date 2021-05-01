source "virtualbox-iso" "LEMP" {
  
  guest_os_type = "Ubuntu_64"
  vm_name = "ubuntu server levan - packer"
  
  iso_url = "https://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso"
  iso_checksum = "sha256:b23488689e16cad7a269eb2d3a3bf725d3457ee6b0868e00c8762d3816e25848"

  # iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"
  # iso_checksum = "md5:769474248a3897f4865817446f9a4a53"
  
  disk_size = 15000

#  headless = "true" # uncomment when everything is ready, so vbox will run in background
  boot_wait = "5s"
  boot_command = [
    "<enter><wait><enter><wait2><enter><wait2><enter><wait1><enter><wait1><enter><wait><enter><wait45>", # region setup
    "<bs><bs><bs><bs><bs><bs>",   # delete hostname
    "packer",                     # enter hostname
    "<wait><enter><wait2><enter><wait1>",   # get to username window
    "packer",                     # input username
    "<wait><enter><wait>",        # click continue after username input
    "packer",                     # input password
    "<wait><enter><wait>",        # click continue after password input
    "packer",                     # re-type password
    "<wait><enter><wait2>",       # click continue after password re-type
    "<wait><left><enter><wait>",  # use weak password
    "<wait><enter><wait3>",       # do not encrypt home directory
    "<wait><enter><wait10>",      # timezone correct
    "<wait><up><enter><wait>",    # guided - use entire disk
    "<wait><enter><wait3>",       # disk selection
    "<wait><left><enter><wait65>",          # write changes to disk
    "<wait><enter><wait70>",      # proxy settings
    "<wait><enter><wait5>",       # disable automatic updates
    "<wait><down><down><down><down><down><down><down><down><wait><spacebar><wait><enter><wait135>", # Install OpenSSH Server and continue
    "<wait><enter><wait30>",      # confirm that cd is removed
    "packer",                     # input username
    "<wait><enter><wait>",        # click enter after password input
    "packer",                     # input password
    "<wait><enter><wait>",        # click enter after password input
  ]

  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

  ssh_username = "packer"
  ssh_password = "packer"
  ssh_wait_timeout = "60m"
#  ssh_pty = true


  vboxmanage = [
      ["modifyvm", "{{.Name}}", "--firmware", "EFI" ],
      ["modifyvm", "{{.Name}}", "--memory", "512"],
      ["modifyvm", "{{.Name}}", "--cpus", "1"],
  ]

}

build {
  sources = ["sources.virtualbox-iso.LEMP"]

  # provisioner "file" {
  #   # 
  #   source = "transfer/mysql_setup.sh"
  #   destination = "/home/packer/mysql_setup.sh"
  # }
  #
  # provisioner "shell" {
  #   # general configurations
  #   inline = [
  #     "sleep 30",
  #     "echo packer | sudo -S apt-get update",
  #     "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections"
  #     "echo debconf mysql-server/root_password password root | sudo debconf-set-selections",
  #     "echo debconf mysql-server/root_password_again password root | sudo debconf-set-selections",

  #     "echo packer | sudo -S apt-get install -y -q nginx",
  #     "echo packer | sudo -S ufw allow 'Nginx HTTP'",

  #     "echo packer | sudo -S apt-get -y -qq install mysql-server mysql-client > /dev/null",

  #     "echo packer | sudo -S bash /home/packer/mysql_setup.sh --u packer --p packer",

  #     "echo packer | sudo -S apt-get -y install php-fpm php-mysql",

  #     "echo packer | sudo -S systemctl restart nginx.service",
  #     "echo packer | sudo -S systemctl enable nginx.service",

  #     "echo packer | sudo -S systemctl restart nginx",
  #     "echo packer | sudo -S systemctl restart php7.0-fpm",

  #     "echo packer | sudo -S mkdir /var/www/levan_domain",
  #     "echo packer | sudo -S chown -R $USER:$USER /var/www/levan_domain"      

  #   ]
  # }

  provisioner "file" {
    source = "transfer/general_configuration.sh"
    destination = "/home/packer/general_configuration.sh"
  
  }

  provisioner "shell" {
    # general configuration
    inline = [
      "echo --------------------1",
      "sleep 30",
      "echo --------------------2",
      "echo packer | sudo -S apt-get update",
      "echo --------------------3",

      # "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections",
      # "echo debconf mysql-server/root_password password root | sudo debconf-set-selections",
      # "echo debconf mysql-server/root_password_again password root | sudo debconf-set-selections",

      "echo --------------------4",
      "echo packer | sudo -S bash /home/packer/general_configuration.sh",
      "echo --------------------5",

      # "echo packer | sudo -S debconf-set-selections <<< \"'debconf debconf/frontend select Noninteractive'\"",
      # "echo packer | sudo -S debconf-set-selections <<< \"debconf mysql-server/root_password password root\"",
      # "echo packer | sudo -S debconf-set-selections <<< \"mysql-server/root_password_again password root\"",

    ]
    
  }

  provisioner "shell" {
    # ngnix
    inline = [
      "echo --------------------6",
      "echo packer | sudo -S apt-get install -y -q nginx",
      "echo --------------------7",
      "echo packer | sudo -S ufw allow 'Nginx HTTP'",
      "echo --------------------8",
    ]
  }

  provisioner "file" {
    # transfer mysql interactive installer file
    source = "transfer/mysql_setup.sh"
    destination = "/home/packer/mysql_setup.sh"
  }

  provisioner "shell" {
    # mysql
    inline = [
      "echo --------------------9",
      "echo packer | sudo -S apt-get -y -qq install mysql-server",
      "echo --------------------10",
      "echo packer | sudo -s apt-get -y -qq install mysql-client",
      "echo --------------------11",
      "echo packer | sudo -S bash /home/packer/mysql_setup.sh -u packer -p packer",
    ]
  }

  provisioner "shell" {
    # php
    inline = [
      "echo --------------------12",
      "echo packer | sudo -S apt-get -y install php-fpm php-mysql",
    ]
  }

  provisioner "shell" {
    # restarts
    inline = [
      "echo --------------------13",
      "echo packer | sudo -S systemctl stop nginx.service",
      "echo --------------------14",
      "echo packer | sudo -S systemctl start nginx.service",
      "echo --------------------15",
      # "echo packer | sudo -S systemctl enable nginx.service",
      "echo packer | sudo -S systemctl restart nginx",
      "echo --------------------16",
      "echo packer | sudo -S systemctl restart php7.0-fpm",
      "echo --------------------17",
    ]
  }

  provisioner "shell" {
    # domain handling
    inline = [
      "echo --------------------18",
      "echo packer | sudo -S mkdir /var/www/levan_domain",
      "echo --------------------19",
      "echo packer | sudo -S chown -R $USER:$USER /var/www/levan_domain",  
      "echo --------------------20",
    ]
  }

  provisioner "file" {
    # transfer domain file
    source = "transfer/levan_domain"
    destination = "/home/packer/levan_domain"
  }

  provisioner "shell" {
    # update available sites and restart service
    inline = [
      "echo --------------------21",
      "echo packer | sudo -S cp /home/packer/levan_domain /etc/nginx/sites-available/levan_domain",
      "echo --------------------22",
      "echo packer | sudo -S ln -s /etc/nginx/sites-available/levan_domain /etc/nginx/sites-enabled/",
      "echo --------------------23",
      "echo packer | sudo -S systemctl restart nginx",
      "echo --------------------23",
    ]
  }



}

