<#
.SYNOPSIS
    Sets the pagefile to a declared size.
.NOTES
    Author: Cody Wellman <cody.wellman@quartz.systems>
#>

[CmdletBinding()]
param (
    [Parameter()]
    [int]$initialSize

    [Parameter()]
    [int]$maximumSize
)

$pagefileSize = @{
    InitialSize = $initialSize
    MaximumSize = $maximumSize
}

# Locates the current pagefile.
$pagefile = Get-CimInstance -ClassName "Win32_PageFileSetting" -Filter "Name like '%pagefile.sys'"

# Deletes the current pagefile.
$pagefile | Remove-CimInstance

# Creates the new pagefile.
$pagefile = New-CimInstance -ClassName "Win32_PageFileSetting" -Property @{ Name = "C:\pagefile.sys" }

# Set's the size of the new pagefile.
$pagefile | Set-CimInstance -Property $pagefileSize
