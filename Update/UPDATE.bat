@echo off

setlocal enabledelayedexpansion
chcp 65001 
::--------------------------------------------/download FILElist/------------------------------------------------------
ftp.exe -s:D:\zabbix\Update\config.ini
::-------------------------------------------------------------/config settings to download files/--------------------
cd.>D:\zabbix\Update\download.ini
echo open 192.168.0.6  >>  D:\zabbix\Update\download.ini
echo zbx>>  D:\zabbix\Update\download.ini
echo zabbix>>  D:\zabbix\Update\download.ini
echo binary>>  D:\zabbix\Update\download.ini
SET adr=D:\zabbix\
SET File=D:\zabbix\Update\filelist.ini
FOR /F "usebackq tokens=*" %%I IN ("%File%") DO ECHO get %%I %adr%%%I>>D:\zabbix\Update\download.ini
REN %File% %File%.old&&REN D:\zabbix\Update\download.ini %File%
echo close>>  D:\zabbix\Update\download.ini
echo quit>>  D:\zabbix\Update\download.ini
::---------------------------------------------------------------/download files by config in download.ini/-------------
ftp.exe -s:D:\zabbix\Update\download.ini
powershell.exe -nologo -noninteractive -windowStyle hidden -command "D:\zabbix\install.ps1"