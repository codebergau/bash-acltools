#!/bin/bash

# Assign timestamp to $TS
TS=$(date +"%s")
BASE=`pwd -P`

# Checks if SUDO
if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "Terminating script"
	exit 1
fi

# Checks if requisite directories exist in /root
# if not creates them

if [ ! -d "acl-backups" ]; then
        echo -e "Directory $BASE/acl-backups/ does not exist"
        echo -e "Creating it now"
        mkdir acl-backups
fi

echo "\n"
# Creates an ACL file for each folder in /
echo $LNBRK
for D in /*; do
    if [ -d "${D}" ]; then
        echo "Preserving ACLs for all directories"
        D1=${D:1:${#D}}
        echo -e "Creating: $BASE/acl-backups/$TS-$D1.acl"
        getfacl -R $D >> $BASE/acl-backups/$TS-$D1.acl
    fi
done
echo "\n"
echo -e "Backup complete"
