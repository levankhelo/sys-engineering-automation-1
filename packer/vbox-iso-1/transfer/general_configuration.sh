#!/bin/bash


echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections;
echo debconf mysql-server/root_password password root | debconf-set-selections;
echo debconf mysql-server/root_password_again password root | debconf-set-selections;