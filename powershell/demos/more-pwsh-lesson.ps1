if ($ConSeats -gt $LibSeats) {
"Libs are Mad, bro"
}
elseif ($LibSeats -gt $ConSeats) {
"Cons are mad,bro"
}
else {
 "Nobody happy, everyone mad"
}

#looping while and until
for ($counter = 0; $doghappy -ne $true; $counter++) {
    pet-dog
    feed-dog
    }


$totalcapacity = 0
get-wmiobject -class win32_physicalmemory |
foreach {
 new-object -TypeName psobject -Property @{
 Manufacturer = $_.manufacturer
 "Speed(MHz)" = $_.speed
 "Size(MB)" = $_.capacity/1mb
 Bank = $_.banklabel
 Slot = $_.devicelocator
 }
 $totalcapacity += $_.capacity/1mb
} |
ft -auto Manufacturer, "Size(MB)", "Speed(MHz)", Bank, Slot
"Total RAM: ${totalcapacity}MB "
