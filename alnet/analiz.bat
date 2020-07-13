@echo off
setlocal enabledelayedexpansion
set camfile=D:\zabbix\alnet\cam\
FOR /f "tokens=*" %%G in (D:\zabbix\alnet\tmp.txt) DO (
set lstate=%%G
echo !lstate!
if not "!lstate!" equ "!lstate:lost=!" (
	set var=echo 0
	set cam=!lstate!
	set pat=%camfile%!cam:~96,2!.bat
	cd.>!pat!
	echo @echo off>>!pat!
	echo !var!>>!pat!
	echo !pat!
) else (
if not "!lstate!" equ "!lstate:restored=!" (
	set var=echo 2
	set cam=!lstate!
	set pat=%camfile%!cam:~98,2!.bat
	cd.>!pat!
	echo @echo off>>!pat!
	echo !var!>>!pat!
	echo !pat!
) else (
if not "!lstate!" equ "!lstate:start capture:=!" (

	set var=echo 1
	set cam=!lstate!
	set pat=%camfile%!cam:~80,1!.bat
	cd.>!pat!
	echo @echo off>>!pat!
	echo !var!>>!pat!
	echo !pat!
)
)
)
)
