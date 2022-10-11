#my system information for Bash Scripting Lab 01
#Created backup of Lab 01 to sysinfo-baackup.sh. Updating this file for Lab 02

# This is a formatted list for system information
echo "Report for my $(hostname)"
echo "==============="
# Display FQDN of the system
echo "FQDN: $(hostname --fqdn)"

# Display my Operating System
source /etc/os-release
echo "Operating System name and version: $PRETTY_NAME"

# Display the IP Address of the system
echo "IP Addresses: $(hostname -I)" #print IP label and address

# Display available space on my root drive
#assign available space to available_space variable
available_space=$(df -h / | awk 'NR==2 {print $4}')S
echo "Root Filesystem Free Space: $available_space"
echo "==============="