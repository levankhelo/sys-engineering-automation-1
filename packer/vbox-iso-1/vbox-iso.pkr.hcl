source "virtualbox-iso" "LEMP" {
  
  guest_os_type = "Ubuntu_64"
  vm_name = "ubuntu server levan - packer"
  
  iso_url = "https://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso"
  iso_checksum = "sha256:b23488689e16cad7a269eb2d3a3bf725d3457ee6b0868e00c8762d3816e25848"

  # iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"
  # iso_checksum = "md5:769474248a3897f4865817446f9a4a53"
  
  disk_size = 15000

#  headless = "true"
  boot_wait = "5s"
  boot_command = [
    "<enter><wait><enter><wait2><enter><wait2><enter><wait1><enter><wait1><enter><wait><enter><wait45>", # region setup
    "<bs><bs><bs><bs><bs><bs>",       # delete hostname
    "packer",               # enter hostname
    "<wait><enter><wait2><enter><wait1>",   # get to username window
    "packer",               # input username
    "<wait><enter><wait>",        # click continue after username input
    "packer",               # input password
    "<wait><enter><wait>",        # click continue after password input
    "packer",               # re-type password
    "<enter><wait2>",        # click continue after password re-type
    "<left><enter><wait>",  # use weak password
    "<enter><wait3>",       # do not encrypt home directory
    "<enter><wait10>",      # timezone correct
    "<up><enter><wait>",    # guided - use entire disk
    "<enter><wait3>",       # disk selection
    "<left><enter><wait65>",          # write changes to disk
    "<enter><wait60>",      # proxy settings
    "<enter><wait3>",       # disable automatic updates
    "<down><down><down><down><down><down><down><down><wait><spacebar><wait><enter><wait135>", # Install OpenSSH Server and continue
    "<wait><enter><wait30>",      # confirm that cd is removed
    "packer",               # input username
    "<wait><enter><wait>",       # click enter after password input
    "packer",               # input password
    "<wait><enter><wait>",       # click enter after password input
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
  provisioner "shell" {
    inline = [
      "sleep 30",
      "echo packer | sudo -S apt-get update",
      "echo packer | sudo -S apt-get install -y nginx",
      
      "echo packer | sudo -S ufw allow 'Nginx HTTP'",

      "echo debconf mysql-server/root_password password root | sudo debconf-set-selections"
      "echo debconf mysql-server/root_password_again password root | sudo debconf-set-selections"

      "echo packer | sudo -S apt-get -y -qq install mysql-server > /dev/null",

      "mysql_secure_installation"


      "echo packer | sudo -S apt-get -y install php-fpm php-mysql",

      "echo packer | sudo -S systemctl stop nginx.service",
      "echo packer | sudo -S systemctl start nginx.service",
      "echo packer | sudo -S systemctl enable nginx.service",

      "echo packer | sudo -S systemctl restart nginx",
      "echo packer | sudo -S systemctl restart php7.0-fpm",

      "echo packer | sudo -S mkdir /var/www/levan_domain"
      "echo packer | sudo -S chown -R $USER:$USER /var/www/levan_domain"
      
      

      

    ]
  }
}

