$version = (Get-Content D:\Zabbix\zabbix_agentd.conf)[0] -replace ".*="
$new_version = (Get-Content D:\Zabbix\install.bat)[68] -replace ".*="
if ($version -lt $new_version) {
$conf_file="D:\zabbix\zabbix_agentd.conf"
New-Item -Path $conf_file -ItemType File -Force
#Set-Content $conf_file "#Version=1.1"
Add-content $conf_file "#Version=1.2" 
Add-content $conf_file "Server=192.168.0.78"
Add-content $conf_file "ServerActive=192.168.0.78"
}
