#environment variable to COMP2101
$env:Path = "$env:Path;C:\Users\Amir\Documents\Github\COMP2101\powershell"

#function for mydisks
function get-mydisks {
    Get-Disk | Format-Table Manufacturer,Model,SerialNumber,FirmwareVersion,Size
}

#get-todays date
$userDay = (Get-Date).DayOfWeek

#create a function with welcome message
function welcome {
    "Welcome Amir, hope you're having a great $userDay!"
}

#new alias np for notepad
New-Item -Path Alias:np -Value notepad | Out-Null
Get-Alias np | Out-Null

#function to show cpu information
function get-cpuinfo {
    Get-WmiObject -Class win32_processor
}

function get-networkadapter {
    #create script for network adapter report using Get-CimInstance Win32_NetworkAdapterConfiguration class
    #look for enabled adapter only
    Get-CimInstance Win32_NetworkAdapterConfiguration -filter "IPEnabled = 'True'" |
    #create an object and have it display Description, Index, IPAddress, SubnetMask, DNSDomain and DNS Server in table
    Select-Object Description, Index, IPAddress, SubnetMask, DNSDomain, DNSServerSearchOrder | Format-Table
}

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
welcome