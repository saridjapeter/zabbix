$version = (Get-Content D:\Zabbix\zabbix_agentd.conf)[0] -replace ".*="
$new_version = (Get-Content D:\Zabbix\install.bat)[68] -replace ".*="
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
Add-content $conf_file "UserParameter=NAME[*],D:\zabbix\info.bat $1"
Add-content $conf_file "UserParameter=INFO[*],D:\zabbix\$1"
Add-content $conf_file "UserParameter=CASH[*],call D:\zabbix\KKM.bat $1"
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
}
