function myfunc {
"this is my function"
"it creates a couple of string objects and just lets them display by default"
}
ls function:
ls function:myfunc
Get-Content function:myfunc


ls function: | more
Get-Alias | more

Get-Process
Get-Process | sort cpu
Get-Process | sort cpu | more

get-process | sort cpu | select -last 10
Get-Process | select -Last 10 | sort cpu

Get-Host

Get-Host | Get-Member
Get-Host | Get-member -MemberType Method
Get-Host | Get-Member -MemberType Property

Get-Date
Get-Date | Get-Member
Get-Date | Get-Member -MemberType Method
Get-Date | Get-Member -MemberType Property

Get-Process
ps
Get-WmiObject -Class win32_process


ps | Get-Member | more
Get-WmiObject -Class win32_process | Get-Member | more


get-host | format-list *
get-date | Format-List *
Get-Process | Format-List * | more
Get-WmiObject -Class win32_process | format-list * | more


(Get-Date).GetType()

("test").GetType()
(5).gettype()

("a","b","c").Length
("a","b","c").Count

(Get-Date).DayOfWeek
(Get-Date).DayOfWeek | Get-Member

Get-Process powershell
Get-Process powershell | format-list *
(Get-Process powershell).StartInfo
(Get-Process powershell).StartInfo.UserName

(gwmi -Class win32_process).getowner()
(gwmi -Class win32_process).getowner().user
