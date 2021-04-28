source "virtualbox-iso" "basic-example" {
  guest_os_type = "Ubuntu_64"
  iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"
  iso_checksum = "md5:769474248a3897f4865817446f9a4a53"
  ssh_username = "packer"
  ssh_password = "packer"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  vboxmanage = [
      ["modifyvm", "{{.Name}}", "--firmware", "EFI" ],
      ["modifyvm", "{{.Name}}", "--memory", "1024"],
      ["modifyvm", "{{.Name}}", "--cpus", "2"],
  ]
}

build {
  sources = ["sources.virtualbox-iso.basic-example"]
}

