#!/bin/bash

# AUTHOR NOTES:
# [+] This script must be run as root.
# [+] This script must have executable permissions to run.
# [+] Thanks to jimbalaya71 --> https://gist.github.com/alateas/3436036

if [ ! -n "$1" ] ; then
	echo 'Missing argument: new_hostname'
	exit 1
fi

if [ "$(id -u)" != "0" ] ; then
	echo "Sorry, you are not root."
	exit 2
fi

CUR_HOSTNAME=$(cat /etc/hostname)
NEW_HOSTNAME=$1

# Display the current hostname
echo "The current hostname is $CUR_HOSTNAME"

# Change the hostname
hostnamectl set-hostname $NEW_HOSTNAME
hostname $NEW_HOSTNAME

# Change hostname in /etc/hosts & /etc/hostname
sudo sed -i "s/$CUR_HOSTNAME/$NEW_HOSTNAME/g" /etc/hosts
sudo sed -i "s/$CUR_HOSTNAME/$NEW_HOSTNAME/g" /etc/hostname

# Display new hostname
echo "The new hostname is $NEW_HOSTNAME"
echo "Please restart your machine at your convienience."
