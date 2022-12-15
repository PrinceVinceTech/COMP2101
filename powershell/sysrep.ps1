
#create a system information report about the current system
$hardWdescription = Get-CIMInstance Win32_ComputerSystem
$hardWdescription | Format-List *

#create information about operating system name, version number (win32_operatingsystem)
$operatingSystem = Get-CIMInstance Win32_OperatingSystem

#create information summary of RAM installed with vendor, description, size, and bank and slot for each RAM module
$ramInfo = Get-CIMInstance Win32_PhysicalMemory

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
$networkInfo = .\adapters.ps1
$networkInfo

#create a report for videocard vendor, description, and memory size