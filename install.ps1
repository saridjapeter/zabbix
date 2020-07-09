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
$IP = $values -replace ".*@" -replace ":.*"
$hostname=
Add-content $conf_file $hostname
}
