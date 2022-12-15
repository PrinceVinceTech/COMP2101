
#create a system information report about the current system in functions

function hardwareDescription {
    #function for hardware description
    $hardWdescription = Get-CIMInstance Win32_ComputerSystem
    $hardWdescription | Format-Table *
    
}

function operatingSys {
    #create information about operating system name, version number (win32_operatingsystem)
    $operatingSystem = Get-CIMInstance Win32_OperatingSystem
    $operatingSystem | Format-Table SystemName, Version
}

function cpuInfo {
    #create information about Processor description with speed, number of cores, and sizes of L1, L2, and L3 caches if they are present (win32_processor)
    $cpuInfo = Get-CIMInstance Win32_Processor
    $cpuInfo | Format-Table Name, Description, MaxClockSpeed, NumberOfCores, L1CacheSize, L2CacheSize, L3CacheSize
}

function ramInfo {
    #create information summary of RAM installed with vendor, description, size, and bank and slot for each RAM module
    $ramInfo = Get-CIMInstance Win32_PhysicalMemory
    $ramInfo | Format-Table Vendor, Description, Capacity, BankLabel, DeviceLocator
}

function diskInfo {
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
}

function networkInfo {
    $networkInfo = adapters.ps1
    $networkInfo
}

function gpuInfo { 
    #create a report for videocard vendor, description, screen resolution in horizontal and vertical pixels (win32_videocontroller)

    $videoInfo = Get-CIMInstance Win32_VideoController
    $videoInfo | Format-Table Name, Description, CurrentHorizontalResolution , CurrentVerticalResolution
}

"System Information Report"
"========================="

"Hardware Description"
"--------------------"
hardwareDescription


"Operating System"
"----------------"
operatingSys


"CPU Information"
"---------------"
cpuInfo

"RAM Information"
"---------------"
ramInfo

"Disk Information"
"---------------"
diskInfo

#use adapters.ps1 to get the network adapter information
"Network Information"
"---------------"
networkInfo

"Video Information"
"---------------"
gpuInfo