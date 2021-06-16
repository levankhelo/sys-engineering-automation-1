# Execution results

## Command

```bash
packer build firstrun.pkr.hcl
```

## Log

```ruby
amazon-ebs.firstrun: output will be in this color.

==> amazon-ebs.firstrun: Prevalidating any provided VPC information
==> amazon-ebs.firstrun: Prevalidating AMI Name: levan ubuntu from packer
    amazon-ebs.firstrun: Found Image ID: ami-0ba21e69b20d84fd7
==> amazon-ebs.firstrun: Creating temporary keypair: packer_60892ee6-887f-8a56-79c0-09394b90ec21
==> amazon-ebs.firstrun: Creating temporary security group for this instance: packer_60892ef3-2ac4-073f-fe88-bfc0ed267d64
==> amazon-ebs.firstrun: Authorizing access to port 22 from [0.0.0.0/0] in the temporary security groups...
==> amazon-ebs.firstrun: Launching a source AWS instance...
==> amazon-ebs.firstrun: Adding tags to source instance
    amazon-ebs.firstrun: Adding tag: "Name": "Packer Builder"
    amazon-ebs.firstrun: Instance ID: i-07f63b38d43b77299
==> amazon-ebs.firstrun: Waiting for instance (i-07f63b38d43b77299) to become ready...
==> amazon-ebs.firstrun: Using ssh communicator to connect: 54.227.60.103
==> amazon-ebs.firstrun: Waiting for SSH to become available...
==> amazon-ebs.firstrun: Connected to SSH!
==> amazon-ebs.firstrun: Uploading ./transfer/welcome.txt => /home/ubuntu/
    amazon-ebs.firstrun: welcome.txt 18 B / 18 B [================================================================================================================================================] 100.00% 2s
==> amazon-ebs.firstrun: Provisioning with shell script: /tmp/packer-shell289226338
    amazon-ebs.firstrun: total 32
    amazon-ebs.firstrun: drwxr-xr-x 4 ubuntu ubuntu 4096 Apr 28 09:47 .
    amazon-ebs.firstrun: drwxr-xr-x 3 root   root   4096 Apr 28 09:47 ..
    amazon-ebs.firstrun: -rw-r--r-- 1 ubuntu ubuntu  220 Aug 31  2015 .bash_logout
    amazon-ebs.firstrun: -rw-r--r-- 1 ubuntu ubuntu 3771 Aug 31  2015 .bashrc
    amazon-ebs.firstrun: drwx------ 2 ubuntu ubuntu 4096 Apr 28 09:47 .cache
    amazon-ebs.firstrun: -rw-r--r-- 1 ubuntu ubuntu  655 Jul 12  2019 .profile
    amazon-ebs.firstrun: drwx------ 2 ubuntu ubuntu 4096 Apr 28 09:47 .ssh
    amazon-ebs.firstrun: -rw-rw-r-- 1 ubuntu ubuntu   18 Apr 28 09:47 welcome.txt
    amazon-ebs.firstrun: WELCOME TO PACKER
==> amazon-ebs.firstrun: Provisioning with shell script: ./transfer/example.sh
    amazon-ebs.firstrun: Hello
==> amazon-ebs.firstrun: Stopping the source instance...
    amazon-ebs.firstrun: Stopping instance
==> amazon-ebs.firstrun: Waiting for the instance to stop...
==> amazon-ebs.firstrun: Creating AMI levan ubuntu from packer from instance i-07f63b38d43b77299
    amazon-ebs.firstrun: AMI: ami-0e16fbca691ae13ef
==> amazon-ebs.firstrun: Waiting for AMI to become ready...
==> amazon-ebs.firstrun: Terminating the source AWS instance...
==> amazon-ebs.firstrun: Cleaning up any extra volumes...
==> amazon-ebs.firstrun: No volumes to clean up, skipping
==> amazon-ebs.firstrun: Deleting temporary security group...
==> amazon-ebs.firstrun: Deleting temporary keypair...
Build 'amazon-ebs.firstrun' finished after 4 minutes 37 seconds.

==> Wait completed after 4 minutes 37 seconds

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs.firstrun: AMIs were created:
us-east-1: ami-0e16fbca691ae13ef

```

## Results

![Results](https://github.com/levankhelo/sys-engineering-automation-1/blob/main/packer/aws-ubuntu-ami-1/artifacts/res-aws-ami-1.png?raw=true)

![Results](https://github.com/levankhelo/sys-engineering-automation-1/blob/main/packer/aws-ubuntu-ami-1/artifacts/res-aws-ami-2.png?raw=true)
