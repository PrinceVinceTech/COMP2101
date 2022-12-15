$a=5 ; $a.gettype()
$b="red"; $b.gettype()
$a="red"; $a.gettype()
$a=37.5; $a.gettype()
[int]$a=76
$a=8gb
[long]$a=20gb; $a
[int64]$a=20gb; $a
$a=6.5; $a
[double]$a=6.5; $a
$d=get-date; $d
$d=5; $d
[datetime]$d=5pb; $d
[bool]$f=0; $f
$f=1; $f
$f="no"; $f
$f=$true; $f

#empty associative variable
@{}

$h = a{}
$h["blue"] = "lobster"
$h["red"] = "cardinal"
$h

$h = @{ } ; $h["blue"] = "lobster" ; $h["red"] = "cardinal" ; $h


$adapters = gwmi -Class win32_networkadapter
$adapters[1,3,4]

$filteredadapters = $adapters | Where-Object adaptertype -Match ethernet
$filteredadapters
$filteredadapters | Select-Object Name, MACAddress, @{n="Speed(Mb)";e={$_.Speed/1000000 -as [int]}}, Netenabled, PowerManagementSupported | Format-Table -AutoSize

$filteredadapters | Select-Object Name, MACAddress, @{n="Speed(Mbps)";e={$_.Speed/1e6 -as [int]}}, Netenabled, PowerManagementSupported | Format-Table -AutoSize



gwmi -class win32_logicaldisk |
where-object size -gt 0 |
format-table -autosize DeviceID,
 @{n="Size(GB)"; e={$_.size/1gb -as [int]}},
 @{n="Free(GB)"; e={$_.freespace/1gb -as [int]}},
 @{n="% Free"; e={100*$_.freespace/$_.size -as [int]}},
 ProviderName

 $MyInvocation #same as $0 in bash
 
