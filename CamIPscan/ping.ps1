if (Test-Path -Path 'E:\video\')
{
cmd /c D:\Zabbix\CamIPscan\scan_seva.bat
gc D:\Zabbix\CamIPscan\ip_seva.txt | where {$_ -ne ""} > D:\Zabbix\CamIPscan\ip.txt
$ip_full = 'D:\Zabbix\CamIPscan\ip.txt'
$storage_for_save = "D:\Zabbix\cam.zbx"
$values = Get-Content $ip_full
$IP = $values -replace ".*@" -replace ":.*"
foreach ($IP in $IP)
{
    $Ping = New-Object System.Net.NetworkInformation.Ping
    $status = $Ping.Send($IP,1000)
    $status.Status
    if ($status.Status -eq "Success") {0 > $storage_for_save}
    else 
    {
    1 > $storage_for_save
    break
    }
}
}
else {0 > $storage_for_save}
