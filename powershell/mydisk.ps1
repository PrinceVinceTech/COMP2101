#create a function named my-disks
#in a table format with Manufacturer, Model, Serial Number, FirmwareRevision and Size

function my-disks {
    Get-Disk | Format-Table Manufacturer,Model,SerialNumber,FirmwareVersion,Size
}

my-disks

#create a welcome message in the profile
"Welcome Amir, hope you're having a great $myday"

#get-todays date
Get-Date