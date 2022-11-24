#create script for network adapter report using Get-CimInstance Win32_NetworkAdapterConfiguration class
#look for enabled adapter only
Get-CimInstance Win32_NetworkAdapterConfiguration -filter "IPEnabled = 'True'" |
#create an object and have it display Description, Index, IPAddress, SubnetMask, DNSDomain and DNS Server in table
Select-Object Description, Index, IPAddress, SubnetMask, DNSDomain, DNSServerSearchOrder | Format-Table