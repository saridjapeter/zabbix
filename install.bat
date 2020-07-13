powershell -executionpolicy RemoteSigned -file "D:\Zabbix\Version.ps1"
@echo off 
IF NOT EXIST D:\Zabbix\ver.zbx goto finish
setlocal enabledelayedexpansion

echo.
echo.
echo.
call :color C
call :echo "                     @@@@  @@       " 
call :color C
call :echo "                  @@@@@@@  @@@@     " 
call :color C
call :echo "                @@@@@@@   @@   @@   " 
call :color C
call :echo "               @@@@@@   @@@@  @@@@  " 
call :color C
call :echo "              @@@@   @@@@@@  @@@@@@ " 
call :color C
call :echo "              @@@   @@@@   @@@@@@@@ " 
call :color C
call :echo "               @@   @@@@@  @@@@@@@  " 
call :color C
call :echo "                @@@   @@@@@  @@@@   " 
call :color C
call :echo "                  @@@    @@@@       " 
call :color C
call :echo "                     @@@@@@@@       " 
echo.


call :color 0
call :echo "                                     C&R SYSTEMS"
echo.
echo.
echo.
echo.
echo.
>nul timeout/nobreak 3


chcp 65001 
call :color 6
call :echo "Detecting permissions" 



call :color 6
call :echo "Clear defconfig" 
cd.>D:\zabbix\zabbix_agentd.conf


::--------------------------------------------------------------------------------/self test/--------
if %ERRORLEVEL%==0 (
call :color 2
call :echo [OK] 
echo.
) else (
call :color C
call :echo [ERROR]
pause
)
::--------------------------------------------------------------------------------.

call :color 6
call :echo "Set Zabbix server is Zabbix.be2b.ru" 

echo Version=1.11
set word=#Version=1.11
echo %word%>>D:\zabbix\zabbix_agentd.conf

echo Server=192.168.0.78
set word=Server=192.168.0.78
echo %word%>>D:\zabbix\zabbix_agentd.conf

echo ServerActive=192.168.0.78
set word=ServerActive=192.168.0.78
echo %word%>>D:\zabbix\zabbix_agentd.conf



::--------------------------------------------------------------------------------/self test/--------
::𐱮㦰랠﹨⫳
if %ERRORLEVEL%==0 (
call :color 2
call :echo [OK] 
echo.
) else (
call :color C
call :echo [ERROR]
pause
)
::--------------------------------------------------------------------------------.

call :color 6
call :echo "Detect Hostname" 
call D:\zabbix\dayLOG.exe

For /F "Delims=" %%I In ('call "D:\zabbix\info.bat" 1') Do Set tipe=%%~I
For /F "Delims=" %%I In ('call "D:\zabbix\info.bat" 2') Do Set magname=%%~I
For /F "Delims=" %%I In ('call "D:\zabbix\info.bat" 3') Do Set toun=%%~I
For /F "Delims=" %%I In ('call "D:\zabbix\info.bat" 4') Do Set magkey=%%~I
For /F "Delims=" %%I In ('call "D:\zabbix\info.bat" 5') Do Set adr=%%~I
echo !toun!-!magname!-!magkey!
set word=Hostname=!toun!-!magname!-!magkey!
echo !word!>>D:\zabbix\zabbix_agentd.conf
set word=UserParameter=NAME[*],D:\zabbix\info.bat $1
echo !word!>>D:\zabbix\zabbix_agentd.conf
set word=UserParameter=INFO[*],D:\zabbix\$1
echo !word!>>D:\zabbix\zabbix_agentd.conf


::--------------------------------------------------------------------------------/self test/--------
::𐱮㦰랠﹨⫳
if %ERRORLEVEL%==0 (
call :color 2
call :echo [OK] 
echo.
) else (
call :color C
call :echo [ERROR]
pause
)
::--------------------------------------------------------------------------------.

::call :color 6
::call :echo "Set Cash_monitor 1-9" 

::set word=UserParameter=CASH[*],call D:\zabbix\KKM.bat $1
::echo %word%>>D:\zabbix\zabbix_agentd.conf
::set word=#

::--------------------------------------------------------------------------------/self test/--------
::𐱮㦰랠﹨⫳
::if %ERRORLEVEL%==0 (
::call :color 2
::call :echo [OK] 
::echo.
::) else (
::call :color C
::call :echo [ERROR]
::pause
::)
::--------------------------------------------------------------------------------.



::--------------------------------------------------------------/DETECT VIDEO SYSTEM/---------------------------------------------------------------

call :color 6
call :echo "DETECT VIDEO SYSTEM" 


IF EXIST C:\svrLog\log.bin (
::----------------------------------------------------------------------/Alnet/---------------------------------------------------------------------
call :color 2
call :echo "[FOUND] ALNET" 
echo.
echo -----------------------------------------/ALNET/-------------------------------------------------


call :color 6
call :echo "   Set ALNET_Self_Test task" 
SCHTASKS /Create /F /SC HOURLY /TN ALNET_Self_test /TR D:\zabbix\alnet\day.bat

call :color 6
call :echo "   Set Cam_monitor" 

set word1=UserParameter=CAM[*],D:\zabbix\alnet\cam\$1.bat
echo !word1!>>D:\zabbix\zabbix_agentd.conf

call :color 6
call :echo "   Set Metadata ALNET" 
echo HostMetadata=ALNET
set word1=HostMetadata=ALNET !toun! !magname! !tipe!
echo !word1!>>D:\zabbix\zabbix_agentd.conf

echo --------------------------------/END OF ALNET SETTINGS/------------------------------------------

) ELSE (

IF EXIST C:\DSSL (
::----------------------------------------------------------------------/TRASSIR/---------------------------------------------------------------------
call :color 2
call :echo "[FOUND] TRASSIR" 
echo.
echo -----------------------------------------/TRASSIR/-------------------------------------------------


call :color 6
call :echo "   Set TRASSIR_Self_Test task" 
::SCHTASKS /Create /F /SC HOURLY /TN TRASSIR_Self_test /TR D:\zabbix\trassir\hals.bat
Schtasks /Delete /TN TRASSIR_Self_test /F

call :color 6
call :echo "   Set TRASSIR hals status" 

set word1=UserParameter=CAM[*],D:\zabbix\trassir\cam\$1.bat
echo !word1!>>D:\zabbix\zabbix_agentd.conf


call :color 6
call :echo "   Set Metadata TRASSIR" 
echo HostMetadata=TRASSIR
set word1=HostMetadata=TRASSIR !toun! !magname! !tipe!
echo !word1!>>D:\zabbix\zabbix_agentd.conf
IF NOT EXIST "C:\Program Files (x86)\GnuWin32\bin" call D:\zabbix\wget.exe

echo --------------------------------/END OF TRASSIR SETTINGS/------------------------------------------

) ELSE (


call :color C
call :echo "   Set SEVA task"  
echo.
call :color 6
call :echo "Set Metadata KKO" 
echo HostMetadata=KKO
set word1=HostMetadata=SEVA !toun! !magname! !tipe!
echo !word1!>>D:\zabbix\zabbix_agentd.conf
)
)
IF EXIST E:\video (
SCHTASKS /Create /F /SC DAILY /ST 05:00 /TN SEVA_ARCHIVE /TR "PowerShell.exe -nologo -noninteractive -windowStyle hidden -File D:\zabbix\Archive.ps1" /ru Brazers /rp Br22013 

)

::--------------------------------------------------------------------------------/self test/--------
::𐱮㦰랠﹨⫳
if %ERRORLEVEL%==0 (
call :color 2
call :echo [OK] 
echo.
) else (
call :color C
call :echo [ERROR]
pause
)
::--------------------------------------------------------------------------------.


call :color 6
call :echo "Set default monitor settings" 

echo Set check time 1 min
set word=RefreshActiveChecks=60
echo %word%>>D:\zabbix\zabbix_agentd.conf

echo Set log dir
set word=LogFile=D:\zabbix\zabbix_agentd.log
echo %word%>>D:\zabbix\zabbix_agentd.conf

::--------------------------------------------------------------------------------/self test/--------
::𐱮㦰랠﹨⫳
if %ERRORLEVEL%==0 (
call :color 2
call :echo [OK] 
echo.
) else (
call :color C
call :echo [ERROR]
pause
)
::--------------------------------------------------------------------------------.

	call :color 6
	call :echo "Set Self_Test task"
SCHTASKS /Create /F /SC DAILY /ST 00:00 /TN Self_test /TR "D:\zabbix\dayLOG.exe" 
	if %ERRORLEVEL%==0 (
	call :color 2
	call :echo [OK] 
	echo.
	) else (
	call :color C
	call :echo [ERROR]
	)
	
	call :color 6
	call :echo "Start first Self_Test"

chcp 866
call D:\zabbix\dayLOG.exe
chcp 65001
::--------------------------------------------------------------------------------/self test/--------
::𐱮㦰랠﹨⫳
if %ERRORLEVEL%==0 (
call :color 2
call :echo [OK] 
echo.
) else (
call :color C
call :echo [ERROR]
pause
)
::--------------------------------------------------------------------------------.

	call :color 6
	call :echo "Set ArCheck task"
SCHTASKS /Create /F /sc minute /mo 20 /TN ArCheck /TR "D:\zabbix\ArCheck.exe" 
	if %ERRORLEVEL%==0 (
	call :color 2
	call :echo [OK] 
	echo.
	) else (
	call :color C
	call :echo [ERROR]
	)
::--------------------------------------------------------------------------------/self test/--------
::𐱮㦰랠﹨⫳
if %ERRORLEVEL%==0 (
call :color 2
call :echo [OK] 
echo.
) else (
call :color C
call :echo [ERROR]
pause
)
::--------------------------------------------------------------------------------.

::--------------------------------------------------------------------------------/S.M.A.R.T./---------
call :color 6
	call :echo "Set S.M.A.R.T."
rem Добавляем пользовательские параметры
type d:\zabbix\UserParameters.txt>> d:\zabbix\zabbix_agentd.conf
::--------------------------------------------------------------------------------.
@echo off
chcp 866 > nul
cls
rem Устанавливаем smartmontools в тихом режиме
d:\zabbix\smartmontools-7.0-1.win32-setup.exe /S
::--------------------------------------------------------------------------------.	
rem Создание списка дисков
@echo off
md "D:\Zabbix\disks"
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
::--------------------------------------------------------------------------------/self test/--------
::𐱮㦰랠﹨⫳
if %ERRORLEVEL%==0 (
	call :color 2
	call :echo [OK] 
	echo.
	) else (
	call :color C
	call :echo [ERROR]
	)
::-----------------------------------------------------------------------/Check Zabbix Agent service/-----------------------------------------------

chcp 65001
echo ----------------------------------/SERVICE SETTINGS/------------------------------------------

call :color 6
call :echo "   CHECK SERVICE" 
 
for /F "tokens=* delims=: " %%H in ('sc query "Zabbix Agent" ') do (
set state=%%H
  if not "!state!" equ "!state:STATE=!" (
	if not "!state!" equ "!state:RUNNING=!" (
	call :color C
	call :echo "   [SERVICE EXIST AND RUNNING]" 
	call :color C
	call :echo "   TRY TO STOP ZABBIX SERVICE"
	sc stop "Zabbix Agent"
	>nul timeout/nobreak 3
	call :color C
	call :echo "   TRY TO DELETE ZABBIX SERVICE"
	sc delete "Zabbix Agent"
	>nul timeout/nobreak 3
	call :color 6
	call :echo "   INSTALL ZABBIX SERVICE"
	D:\Zabbix\zabbix_agentd.exe --config D:\Zabbix\zabbix_agentd.conf --install
	if %ERRORLEVEL%==0 (
	call :color 2
	call :echo [OK] 
	echo.
	) else (
	call :color C
	call :echo [ERROR]
	)
) else (
if not "!state!" equ "!state:STOPPED=!" (
	call :color C
	call :echo "   [SERVICE EXIST BUT STOPPED]" 
	call :color 6
	call :echo "   TRY TO DELETE ZABBIX SERVICE"	
	sc delete "Zabbix Agent"
	>nul timeout/nobreak 3
	call :color 6
	call :echo "   INSTALL ZABBIX SERVICE"
	D:\Zabbix\zabbix_agentd.exe --config D:\Zabbix\zabbix_agentd.conf --install
	if %ERRORLEVEL%==0 (
	call :color 2
	call :echo [OK] 
	echo.
	) else (
	call :color C
	call :echo [ERROR]
	)
)  
)
)
)

sc query "Zabbix Agent" 1>NUL
if %errorlevel%==1060 (
	call :color 6
	call :echo "   INSTALL ZABBIX SERVICE"
	D:\Zabbix\zabbix_agentd.exe --config D:\Zabbix\zabbix_agentd.conf --install
	if %ERRORLEVEL%==0 (
	call :color 2
	call :echo [OK] 
	echo.
	) else (
	call :color C
	call :echo [ERROR]
	)
)

	call :color 6
	call :echo "   START ZABBIX SERVICE"
	D:\zabbix\zabbix_agentd.exe --start
	if %ERRORLEVEL%==0 (
	call :color 2
	call :echo [OK] 
	echo.
	) else (
	call :color C
	call :echo [ERROR]
	)

echo -------------------------------/END OF SERVICE SETTINGS/----------------------------------------

call :color 6
call :echo "Set UPDATE task" 
SCHTASKS /Create /F /SC DAILY /ST 01:00 /TN Zabbix_Update /TR "D:\zabbix\Update\UPDATE.bat" /ru Brazers /rp Br22013 

echo.
	call :color 6
	call :echo "INSTALL COMPLETE"

echo.

echo -------------------------------/RealTemp/----------------------------------------

@echo off
md "D:\Zabbix\RealTemp"
robocopy \\192.168.0.6\Distr\SRA\Zabbix\RealTemp "D:\Zabbix\RealTemp" /E /XO /R:3 /W:5 /MT:32
SCHTASKS /Create /F /SC onstart /TN RealTemp /TR "D:\Zabbix\RealTemp\RealTemp.exe" /ru Brazers /rp Br22013 
taskkill /IM RealTemp.exe /F
cd /d "D:\Zabbix\RealTemp"
start RealTemp.exe


echo -------------------------------/CAM Ping/----------------------------------------

call :color 6
call :echo "Set UPDATE task" 
md "D:\Zabbix\CamIPscan"
robocopy \\192.168.0.6\Distr\SRA\Zabbix\CamIPscan "D:\Zabbix\CamIPscan" /E /XO /R:3 /W:5 /MT:32
SCHTASKS /Create /F /SC hourly /TN CAM_Ping /TR "PowerShell.exe -nologo -noninteractive -windowStyle hidden -File D:\Zabbix\CamIPscan\ping.ps1" /ru Brazers /rp Br22013 

echo.
	call :color 6
	call :echo "INSTALL COMPLETE"
echo.
echo -------------------------------/LOG BAT/----------------------------------------
robocopy \\192.168.0.6\Distr\SRA\Zabbix\LOG "D:\Zabbix\LOG" /E /XO /R:3 /W:5 /MT:32


echo -------------------------------/TEST RUN SERVICE/----------------------------------------
chcp 866
>nul timeout/nobreak 3
net start | find /i "Zabbix Agent"
if "%errorlevel%"=="1" (
   powershell "restart-computer"
)
exit
::-------------------------------------------------------/LINE AND COLOR/----------------------------------------------------------
:color
 set c=%1& exit/b
 
:echo
 for /f %%i in ('"prompt $h& for %%i in (.) do rem"') do (
  pushd "%~dp0"& <nul>"%~1_" set/p="%%i%%i  "& findstr/a:%c% . "%~1_*"
  (if "%~2" neq "/" echo.)& del "%~1_"& popd& set c=& exit/b
 )   
:finish
 exit