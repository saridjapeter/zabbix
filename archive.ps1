clear-content D:\Zabbix\Archive.zbx
Get-ChildItem "E:\video" | Measure-Object | %{$_.Count}>>D:\Zabbix\Archive.zbx