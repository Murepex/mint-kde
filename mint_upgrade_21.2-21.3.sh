#!/bin/bash
echo "Mint Upgrade 21.2 to 21.3"
echo "Update? [y/n]"
set -e
read confirm

if [ "$confirm" == "y" ]; then
    sudo apt update
    sudo apt upgrade -y
    sudo sed -i 's/victoria/virginia/g' /etc/apt/sources.list.d/official-package-repositories.list
    sudo apt update
    sudo apt dist-upgrade -y
fi
