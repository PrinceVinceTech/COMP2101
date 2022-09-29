#!/bin/bash
# This script will display my system information for Bash Scripting Lab 01

# Display FQDN of the system
echo "FQDN: $(hostname --fqdn)"

# Display the hostname of the system
echo "Hostname: $(hostname)"

# Display Host information
echo "Host Information:"
echo "$(hostnamectl)"

# Display the IP Address of the system
echo "IP Addresses:"
echo "$(hostname -I)"

# Display Root Filesystem Status
echo "Root Filesystem Status:"
echo "$(df -h /)"