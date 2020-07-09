$version = (Get-Content D:\Zabbix\zabbix_agentd.conf)[0] -replace ".*="
$new_version = (Get-Content D:\Zabbix\install.bat)[68] -replace ".*="
if ($version -lt $new_version) {

}
