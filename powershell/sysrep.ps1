
#create a system information report about the current system
"System Information Report"
"========================="

"Hardware Description"
"--------------------"
$hardWdescription = Get-CIMInstance Win32_ComputerSystem
$hardWdescription | Format-Table *

"Operating System"
"----------------"
#create information about operating system name, version number (win32_operatingsystem)
$operatingSystem = Get-CIMInstance Win32_OperatingSystem
$operatingSystem | Format-Table SystemName, Version

"CPU Information"
"---------------"
#create information about Processor description with speed, number of cores, and sizes of L1, L2, and L3 caches if they are present (win32_processor)
$cpuInfo = Get-CIMInstance Win32_Processor
$cpuInfo | Format-Table Name, Description, MaxClockSpeed, NumberOfCores, L1CacheSize, L2CacheSize, L3CacheSize

"RAM Information"
"---------------"
#create information summary of RAM installed with vendor, description, size, and bank and slot for each RAM module
$ramInfo = Get-CIMInstance Win32_PhysicalMemory
$ramInfo | Format-Table Vendor, Description, Capacity, BankLabel, DeviceLocator

"Disk Information"
"---------------"
#create a summary of physical disk with their vendor, model, size, and space usage (size, free space, and percentage free) and format on a signle table with one local disk per output line
$diskInfo = Get-CIMInstance CIM_logicaldisk

foreach ($disk in $diskInfo) {
    $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
    foreach ($partition in $partitions) {
          $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
          foreach ($logicaldisk in $logicaldisks) {
                   new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                             Location=$partition.deviceid
                                                             Drive=$logicaldisk.deviceid
                                                             "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                             }
         }
    }
}
#use adapters.ps1 to get the network adapter information
"Network Information"
"---------------"
$networkInfo = adapters.ps1
$networkInfo

#create a report for videocard vendor, description, and memory size