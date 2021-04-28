source "virtualbox-iso" "LEMP" {
  
  guest_os_type = "Ubuntu_64"
  vm_name = "ubuntu server levan - packer"
  
  iso_url = "https://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso"
  iso_checksum = "sha256:8ba7e2687fb8a2152504475e92e489aace543059fd4ba7ffe10111c42394853b"

  # iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"
  # iso_checksum = "md5:769474248a3897f4865817446f9a4a53"
  
  disk_size = 15000

#  headless = "true"
  boot_wait = "5s"
#  boot_command = [
#    "<enter><wait>",
#    "<f6><esc>",
#    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
#    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
#    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
#    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
#    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
#    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
#    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
#    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
#    "<bs><bs><bs>",
#    "/install/vmlinuz ",
#    "initrd=/install/initrd.gz ",
#    "net.ifnames=0 ",
#    "auto-install/enable=true ",
#    "debconf/priority=critical ",
#    "preseed/url=http://{{.HTTPIP}}:{{.HTTPPort}}/preseed.cfg",
#    "<enter>"
#  ]

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
      "sudo apt-get update",
      "sudo apt-get install -y mysql",
    ]
  }
}

