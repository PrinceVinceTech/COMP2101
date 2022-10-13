#!/bin/bash

# this is the testing script from Overlord Dennis for playing with containers and web servers

# use the which command to see if we have lxd on the system already
which lxd > /dev/null
if [ $? -ne 0 ]; then
    # if we don't have lxd, install it
    echo "lxd is not installed, installing now"
    sudo snap install lxd
    if [ $? -ne 0 ]; then
        echo "lxd installation failed, it is required for this script. Exiting"
        exit 1
    fi
    #failed to install lxd, exit
fi

#lxd software is installed, let's make sure it is running
sudo lxd init --auto

# do we have lxdbr0 interface?
ip link show lxdbr0 > /dev/null

# if we have lxdbr0 proceed to next step
# if we don't have lxdbr0, create it
if [ $? -ne 0 ]; then
    echo "lxdbr0 interface is not present, creating it now"
    sudo lxd init --auto
    if [ $? -ne 0 ]; then
        echo "lxdbr0 interface creation failed, it is required for this script. Exiting"
        exit 1
    fi
fi

# next step is to create a container for Ubuntu 20.04 which is the current LTS and installed on the host
# we will call the server container COMP2101-S22 
# launch lxd container 
lxc launch ubuntu:20.04 COMP2101-S22

# wait for the container to start just to make sure it is ready
echo "Waiting for container to start"
sleep 5
# test stop and remove instance of COMP2101-S22
#lxc stop COMP2101-S22
#lxc delete COMP2101-S22
#lxc list

# list all available containers
lxc list

# this is to get the IP address of COMP2101-S22 and store it in a variable
compIP=$(lxc list | grep COMP2101-S22 | awk '{print$6}')
echo "The IP address of the container is $compIP"

#this is to get COMPIP and add it to etc/hosts for COMP2101-S22
echo "$compIP   COMP2101-S22" | sudo tee -a /etc/hosts

# install apache2 on the container if not already installed
# update quiet flag to -qq to suppress output
lxc exec COMP2101-S22 -- apt update -qq

# install apache2 quietly and yes to all prompts
lxc exec COMP2101-S22 -- apt install apache2 -qqy

# if apache2 is installed then start it
lxc exec COMP2101-S22 -- systemctl start apache2

# check if you can access COMP2101-S22 from the host
curl http://COMP2101-S22

# if you can access COMP2101-S22 echo success message
if [ $? -eq 0 ]; then
    echo "Congratulations! You can access COMP2101-S22. :)"
    exit 0
else
    echo "Sorry, you cannot access COMP2101-S22 from this container :("
    exit 1
fi