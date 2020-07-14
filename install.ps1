#Проверка прав админа
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
#install
if (Test-Path -Path 'D:\Zabbix\zabbix_agentd.conf') {}
else {New-Item -Path 'D:\Zabbix\zabbix_agentd.conf' -ItemType "file"
Set-Content $conf_file "#Version=1.1"}
$version = (Get-Content D:\Zabbix\zabbix_agentd.conf)[0] -replace ".*="
$new_version = (Get-Content D:\Zabbix\install.ps1)[68] -replace ".*="
if ($version -lt $new_version) {
$conf_file="D:\zabbix\zabbix_agentd.conf"
New-Item -Path $conf_file -ItemType File -Force
#Set-Content $conf_file "#Version=1.1"
Add-content $conf_file "#Version=1.2" 
Add-content $conf_file "Server=192.168.0.78"
Add-content $conf_file "ServerActive=192.168.0.78"
& D:\zabbix\dayLOG.exe
#& sqlcmd -S .\sqlexpress -U sa -P mssql -Q "set nocount on;SELECT Data FROM ProcessControl.dbo.Config WHERE Category='Main' AND Name='Unique_ID'" -h -1 -f 65001 -o D:\zabbix\hostAD.ini
$hostAD = Get-Content D:\zabbix\hostAD.ini
$hostAD = $hostAD -split "@"
$hostname = [string]::Concat("Hostname=", $hostAD[2], "-", $hostAD[1], "-", $hostAD[3])
Add-content $conf_file $hostname
Add-content $conf_file 'UserParameter=NAME[*],D:\zabbix\info.bat $1'
Add-content $conf_file 'UserParameter=INFO[*],D:\zabbix\$1'
Add-content $conf_file 'UserParameter=CASH[*],call D:\zabbix\KKM.bat $1'
#-----/DETECT VIDEO SYSTEM/-----
if (Test-Path -Path 'E:\video')
   {
    $HostMetadata = [string]::Concat("HostMetadata=SEVA", " ", $hostAD[2], " ", $hostAD[1], " ", $hostAD[0])
    Add-content $conf_file $HostMetadata
    #-----/Планировщик SEVA/-----
    #Import-Module PSScheduledJob
    #$Trigger = New-JobTrigger -Daily -At 05:00AM
    #Register-ScheduledJob -Name SEVA_ARCHIVE -FilePath "D:\zabbix\Archive.ps1" -Trigger $Trigger
    & SCHTASKS /Create /F /SC DAILY /ST 05:00 /TN SEVA_ARCHIVE /TR "PowerShell.exe -nologo -noninteractive -windowStyle hidden -File D:\zabbix\Archive.ps1"
}
if (Test-Path -Path 'E:\index')
   {
    $HostMetadata = [string]::Concat("HostMetadata=ALNET", " ", $hostAD[2], " ", $hostAD[1], " ", $hostAD[0])
    Add-content $conf_file $HostMetadata
    #-----/Планировщик ALNE/-----
    & SCHTASKS /Create /F /SC HOURLY /TN ALNET_Self_test /TR D:\zabbix\alnet\day.bat
}
Add-content $conf_file "RefreshActiveChecks=60"
Add-content $conf_file "LogFile=D:\zabbix\zabbix_agentd.log"
#-----Self_test task-----
& SCHTASKS /Create /F /SC DAILY /ST 00:00 /TN Self_test /TR "D:\zabbix\dayLOG.exe"
#-----ArCheck task-----
& SCHTASKS /Create /F /sc minute /mo 20 /TN ArCheck /TR "D:\zabbix\ArCheck.exe" 
#-----/S.M.A.R.T./-----
& robocopy \\192.168.0.6\Distr\SRA\Zabbix\disks "d:\zabbix\disks\" /E /XO /R:3 /W:5 /MT:32
Add-content $conf_file (Get-Content d:\zabbix\disks\UserParameters.txt)
& d:\zabbix\disks\smartmontools-7.0-1.win32-setup.exe /S
#Создание списка дисков
& D:\zabbix\disks\disk_chek.bat
#Установка Zabbix службы
get-service "Zabbix Agent" | where {$_.status -eq 'running'} | stop-service -pass
(Get-WmiObject win32_service -Filter "name='Zabbix Agent'").delete()
D:\Zabbix\zabbix_agentd.exe --config D:\Zabbix\zabbix_agentd.conf --install
start-service "Zabbix Agent" -PassThru
#-----Zabbix_Update-----
& SCHTASKS /Create /F /SC DAILY /ST 01:00 /TN Zabbix_Update /TR "D:\zabbix\Update\UPDATE.bat" /ru Brazers /rp Br22013
#-----/RealTemp/-----
& SCHTASKS /Create /F /SC onstart /TN RealTemp /TR "D:\Zabbix\RealTemp\RealTemp.exe" /ru Brazers /rp Br22013
Stop-Process -Name RealTemp
& D:\Zabbix\RealTemp\RealTemp.exe
#-----/CAM Ping/-----
& SCHTASKS /Create /F /SC hourly /TN CAM_Ping /TR "PowerShell.exe -nologo -noninteractive -windowStyle hidden -File D:\Zabbix\CamIPscan\ping.ps1" /ru Brazers /rp Br22013 
#-----/TEST RUN SERVICE/-----
get-service "Zabbix Agent" | where {$_.status -eq 'Stopped'} | restart-computer
Stop-Process -Name PowerShell
}
