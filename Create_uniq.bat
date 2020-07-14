::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion
@cd/d "%~dp0"

call :cfg config.ini Directory Install
set installpath=!tmpvar!
echo [!installpath!]

call :cfg config.ini Time DMS
set DMStime=!tmpvar!
echo [!DMStime!]

call :cfg config.ini Time FR
set FRtime=!tmpvar!
echo [!FRtime!]

call :cfg config.ini ObjectType Videosystem
set Videosystem=!tmpvar!
echo [!Videosystem!]

call :cfg config.ini ObjectType ServiceName
set ServiceName=!tmpvar!
echo [!ServiceName!]

call :cfg config.ini ObjectType TaskName
set TaskName=!tmpvar!
echo [!TaskName!]

call :cfg config.ini ObjectType TableName
set TableName=!tmpvar!
echo [!TableName!]

call :cfg config.ini ObjectType SQLpath
set SQLpath=!tmpvar!
echo [!SQLpath!]

call :cfg config.ini ObjectType SQLu
set SQLu=!tmpvar!
echo [!SQLu!]

call :cfg config.ini ObjectType SQLp
set SQLp=!tmpvar!
echo [!SQLp!]

call :cfg config.ini ObjectType DMS
set DMS=!tmpvar!
echo [!DMS!]

call :cfg config.ini ObjectType FR
set FR=!tmpvar!
echo [!FR!]

call :cfg config.ini Time dayON
set dayON=!tmpvar!
echo [!dayON!]

call :cfg config.ini Time dayOFF
set dayOFF=!tmpvar!
echo [!dayOFF!]

call :cfg config.ini ObjectType UseUniqueID
set UseUniqueID=!tmpvar!
echo [!UseUniqueID!]

call :cfg config.ini ZabbixServer Server
set Server=!tmpvar!
echo [!Server!]

echo.
echo take uniq
set im=sqlcmd -S %SQLpath% -U %SQLu% -P %SQLp% -Q "set nocount on;SELECT Data FROM !TableName!.dbo.Config WHERE Category = 'Main' AND Name = 'Unique_ID'" -h -1 -f 65001 
!im!
echo take object name
set im=sqlcmd -S %SQLpath% -U %SQLu% -P %SQLp% -Q "set nocount on;SELECT Data FROM !TableName!.dbo.Config WHERE Category = 'Main' AND Name = 'ObjectName'" -h -1 -f 65001 
!im!
set /p uniq=set uniq
set im=sqlcmd -S %SQLpath% -U %SQLu% -P %SQLp% -Q "UPDATE !TableName!.dbo.Config SET Data = '!uniq!' WHERE Category = 'Main' AND Name = 'Unique_ID'" -h -1 -f 65001 
!im!


echo take uniq
set im=sqlcmd -S %SQLpath% -U %SQLu% -P %SQLp% -Q "set nocount on;SELECT Data FROM !TableName!.dbo.Config WHERE Category = 'Main' AND Name = 'Unique_ID'" -h -1 -f 65001 
!im!

pause
exit

::_____________________________________________________//call cfg
:cfg
set file=%~1
set area=[%~2]
set key=%~3
set currarea=
for /f "usebackq delims=" %%a in ("!file!") do (
    set ln=%%a
    if "x!ln:~0,1!"=="x[" (
        set currarea=!ln!
    ) else (
        for /f "tokens=1,2 delims==" %%b in ("!ln!") do (
            set currkey=%%b
            set currval=%%c
            if "x!area!"=="x!currarea!" if "x!key!"=="x!currkey!" (
                set tmpvar=!currval!
            )
        )
    )
)
exit/b