### Elevate Credentials ###
param([switch]$Elevated)
function Check-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) }
if ((Check-Admin) -eq $false)  { 
    if ($elevated){ # Could not elevate, quit
} else { 
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ( $myinvocation.MyCommand.Definition ))
    } exit
}
Stop-Process -Name RealTemp
#& D:\Zabbix\RealTemp\RealTemp.exe
Stop-Process -Name PowerShell