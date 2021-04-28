#/!bin/bash
# execute shell module's script on all Linux devices
ansible -i $(dirname "$0")/host-conf -m shell -a 'uname -a' linux 


