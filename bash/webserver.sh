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

# test stop and remove instance of COMP2101-S22
#lxc stop COMP2101-S22
#lxc delete COMP2101-S22
#lxc list

# list all available containers
lxc list

# this is to get the IP address of COMP2101-S22 and store it in a variable
COMPIP=$(lxc list COMP2101-S22 -c 4 --format csv)
echo "The IP address of the container is $COMPIP"

#this is to get COMPIP and add it to etc/hosts for COMP2101-S22
echo "$COMPIP COMP2101-S22" | sudo tee -a /etc/hosts

# install apache2 on the container if not already installed
# update quiet flag to -qq to suppress output
lxc exec COMP2101-S22 -- apt update -qq
# install apache2 if not already installed
lxc exec COMP2101-S22 -- apt install apache2 -qq

# if apache2 is installed then start it
lxc exec COMP2101-S22 -- systemctl start apache2

# check if you can access COMP2101-S22 from the host
wget http://COMP2101-S22

# if you can access COMP2101-S22 echo success message
if [ $? -eq 0 ]; then
    echo "Congratulations! You can access COMP2101-S22. :)"
else
    echo "Sorry, you cannot access COMP2101-S22 from this container :("
fi