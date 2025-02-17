#!/bin/bash
#prompt the user for input before running the script
echo "This script will reset the Minecraft world. Are you sure you want to continue? (y/n)"
read answer
if [ "$answer" != "y" ]; then
    echo "Aborting..."
    exit 1
fi

ansible-playbook -i hosts reset_world.yml

