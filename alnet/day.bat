@echo off
::указать файл с логами
set logfile=C:\svrLog\log1.txt
::указать выходной файл (куда копировать)
set newlog=D:\zabbix\alnet\outlog.txt
set temp=D:\zabbix\alnet\tmp.txt
set lstate=D:\zabbix\alnet\lstate.txt

for /f "tokens=*" %%i in ('powershell "[DateTime]::Now.AddHours(-1).ToString('HH:dd.MM.yyyy')"') do set a1=%%i
set a2=%a1:~3,13%
set a3="%a1:~0,3%"
cd.>%temp%
cd.>%newlog%
for /f "tokens=*" %%a in ('findstr /C:%a2% %logfile%') do  echo %%a>>%temp%
for /f "tokens=*" %%a in ('findstr /C:%a3% %temp%') do  echo %%a>>%newlog%
cd.>%temp%
for /f "tokens=*" %%a in ('findstr "lost restored capture:" %newlog%') do  echo %%a>>%temp%

echo %var%>>D:\zabbix\alnet\lstate.txt

call D:\zabbix\alnet\analiz.bat
cd.>%logfile%

