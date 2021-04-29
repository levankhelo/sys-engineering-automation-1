#!/bin/bash

apt-get -y install expect

UNAME=packer
PWORD=packer

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -p|--password)
    PWORD="$2"
    shift
    shift
    ;;
    -u|--username)
    UNAME="$2"
    shift
    shift 
    ;;
esac
done


MYSQL_ROOT_PASSWORD=$PWORD

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$packer\r\"
expect \"Change the root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

apt-get -y purge expect