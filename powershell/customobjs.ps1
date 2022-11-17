New-Object -TypeName psobject -property @{key1="value1";key2="value2";key3=(Get-Date).Millisecond}

(Get-Date).DayOfWeek | Get-Member -MemberType Property
New-Object -TypeName System.DayOfWeek -Property @{value__=3}

foreach ($c in 1.4)) {
    New-Object -TypeName psobject -Property @{
        PlaceCount=$c;
        MaxValueInBinary=[math]::pow(2,$c);
        MaxValueInOctal=[math]::pow(8,$c);
        }
    }