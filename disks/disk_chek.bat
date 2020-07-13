rem Создание списка дисков
@echo off
echo @echo off > d:\zabbix\disks\disks.cmd
echo echo {"data": >> d:\zabbix\disks\disks.cmd
echo echo    [ >> d:\zabbix\disks\disks.cmd
for /F "tokens=1,3" %%a in ('C:\"Program Files"\smartmontools\bin\smartctl.exe --scan') ^
do (for %%s in ("Device Model" "Product") ^
do (for /F "tokens=2*" %%c in ('C:\"Program Files"\smartmontools\bin\smartctl.exe -i %%a -d %%b ^| find %%s ') ^
do (for %%i in ("Serial Number") do (for /F "tokens=3*" %%k in ('C:\"Program Files"\smartmontools\bin\smartctl.exe -i %%a -d %%b ^| find %%i ') ^
do echo echo      {"{#DISKPORT}":"%%a","{#DISKTYPE}":"%%b","{#DISKMODEL}":"%%d","{#DISKSN}":"%%k"},>> d:\zabbix\disks\disks.cmd))))
echo echo      {"{#SMARTV}":"Smartctl 7.0"}>> d:\zabbix\disks\disks.cmd
echo echo    ] >> d:\zabbix\disks\disks.cmd
echo echo } >> d:\zabbix\disks\disks.cmd
::--------------------------------------------------------------------------------.
rem Включение смарт на всех дисках
for /F "tokens=1" %%a in ('C:\"Program Files"\smartmontools\bin\smartctl.exe --scan') ^
do "C:\Program Files\smartmontools\bin\smartctl.exe" --smart=on --offlineauto=on --saveauto=on %%a