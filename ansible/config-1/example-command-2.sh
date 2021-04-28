#/!bin/bash
# ping all devices in hosts files using ansible's ping module
ansible -i $(dirname "$0")/host-conf -m ping all
