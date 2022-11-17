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

welcome