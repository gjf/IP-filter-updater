@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: HSH
REM Productname: IP filter list downloader for torrent
REM Filedescription: DLs IP filter as ipfilter.dat file
REM Copyrights: © Fixxxer
REM Trademarks: 
REM Originalname: IPfilterDL.exe
REM Comments: https://forum.ru-board.com/topic.cgi?forum=5&topic=50835&start=700#3
REM Productversion:  4. 0. 1. 0
REM Fileversion:  4. 0. 1. 0
REM Internalname: IPfilterDL.exe
REM ExeType: ghost
REM Architecture: x86
REM Appicon: X:\Download Manager\IP filter updater\utorrent.ico
REM AdministratorManifest: No
REM Embeddedfile: X:\Download Manager\IP filter updater\7za.exe
REM Embeddedfile: X:\Download Manager\IP filter updater\aria2c.exe
REM Embeddedfile: X:\Download Manager\IP filter updater\cut.exe
REM Embeddedfile: X:\Download Manager\IP filter updater\cygiconv-2.dll
REM Embeddedfile: X:\Download Manager\IP filter updater\cygintl-8.dll
REM Embeddedfile: X:\Download Manager\IP filter updater\cygwin1.dll
REM Embeddedfile: X:\Download Manager\IP filter updater\sort.exe
REM Embeddedfile: X:\Download Manager\IP filter updater\find.exe
REM Embeddedfile: X:\Download Manager\IP filter updater\cygpcre-1.dll
REM Embeddedfile: X:\Download Manager\IP filter updater\grep.exe
REM  QBFC Project Options End
@ECHO ON
rem del /f /q %myfiles%\file.tmp >nul 2>nul
set "startpath=%~dp0"
set thrash=%date%%time%
set thrash=%thrash:.=%
set thrash=%thrash::=%
set thrash=%thrash:,=%
set thrash=%thrash: =%
if "%~1" equ "+" (set "dlpath1=%~2"
set "dllocal1=")
if "%~3" equ "+" (set "dlpath2=%~4"
set "dllocal2=")
if "%~1" equ "-" (set "dllocal1=%~2"
set "dlpath2=")
if "%~3" equ "-" (set "dlpath2=%~4"
set "dllocal2=")
if "%~1" equ "" (set "dlpath1="
set "dllocal1=")
if "%~3" equ "" (set "dlpath2="
set "dllocal2=")
del /f /q ipfilter.bak >nul 2>nul
if exist ipfilter.dat ren ipfilter.dat ipfilter.bak >nul 2>nul
if "%dllocal1%" neq "" call :lcunpack "%dllocal1%"
if "%dllocal2%" neq "" call :lcunpack "%dllocal2%"
if "%dlpath1%" neq "" call :dlunpack "%dlpath1%"
if "%dlpath2%" neq "" call :dlunpack "%dlpath2%"
call :dlunpack  "http://upd.emule-security.org/ipfilter.zip"
call :dlunpack "https://github.com/DavidMoore/ipfilter/releases/download/lists/ipfilter.dat.gz"
type ipfilter1.dat ipfilter2.dat ipfilter3.dat ipfilter4.dat >ipfilter.dat 2>nul
rem call :dedupe ipfilter.dat
%myfiles%\sort.exe -u ipfilter.dat -o ipfilter.dat
for /l %%i in (1,1,4) do del /f /q ipfilter%%i.dat >nul 2>nul
rem if exist "%userprofile%\AppData\Local\qBittorrent\filter" copy /y ipfilter.dat %userprofile%\AppData\Local\qBittorrent\filter\ipfilter.dat >nul 2>nul
if exist "%userprofile%\AppData\Roaming\uTorrent\" copy /y ipfilter.dat %userprofile%\AppData\Roaming\uTorrent\ipfilter.dat >nul 2>nul
rem wget.exe -N -r --tries=3 http://emulepawcio.sourceforge.net/nieuwe_site/Ipfilter_fakes/ipfilter.dat -O ipfilter.dat
rem wget.exe -N -r --tries=3 http://kent.dl.sourceforge.net/project/emulepawcio/Ipfilter/Ipfilter/ipfilter.dat -O ipfilter.dat
rem move /Y ipfilter.dat "%AppData%\uTorrent\" >nul
exit /b 0

:lcunpack
For %%A in ("%~1") do (
rem    set "lcfullpath=%%~fA"
rem    set "lcdrive=%%~dA"
rem    set "lcpath=%%~pA"
rem    set "lcfile=%%~nA"
rem    set "lcext=%%~xA"
rem    set "lcexpandedpathshortname=%%~sA"
rem    set "lcattrib=%%~aA"
rem    set "lcdatetime=%%~tA"
rem    set "lcsize=%%~zA"
    set "lcdrivepath=%%~dpA"
    set "lcfileext=%%~nxA"
rem    set "lcfullpathshortname=%%~fsA"
)
copy /y "%~1" your.file >nul 2>nul
if "%lcdrivepath%" equ "%startpath%" ren %lcfileext% %lcfileext%.%thrash%.bak >nul 2>nul
call :listparse
if %errorlevel% equ 0 %myfiles%\cut.exe -d',' -f -2 ipfilter.dat >ipfilter0.dat
del /f /q ipfilter.dat >nul 2>nul
if not exist ipfilter1.dat (ren ipfilter0.dat ipfilter1.dat) else if not exist ipfilter2.dat (ren ipfilter0.dat ipfilter2.dat) else if not exist ipfilter3.dat (ren ipfilter0.dat ipfilter3.dat) else if not exist ipfilter4.dat (ren ipfilter0.dat ipfilter4.dat)
exit /b

:dlunpack
For %%A in ("%~1") do (
rem    set "dlfullpath=%%~fA"
rem    set "dldrive=%%~dA"
rem    set "dlpath=%%~pA"
    set "dlfile=%%~nA"
rem    set "dlext=%%~xA"
rem    set "dlexpandedpathshortname=%%~sA"
rem    set "dlattrib=%%~aA"
rem    set "dldatetime=%%~tA"
rem    set "dlsize=%%~zA"
rem    set "dldrivepath=%%~dpA"
    set "dlfileext=%%~nxA"
rem    set "dlfullpathshortname=%%~fsA"
)
del /f /q %dlfileext% >nul 2>nul
%myfiles%\aria2c.exe "%~1" -o %dlfileext% >nul 2>nul
%myfiles%\7za.exe e -y %dlfileext% -o"%startpath%%thrash%\" >nul 2>nul
del /f /q %dlfileext% >nul 2>nul
call :renaming
rem call :decomment ipfilter.dat ipfilter0.dat
if %errorlevel% equ 0 call :listparse
if %errorlevel% equ 0 %myfiles%\cut.exe -d',' -f -2 ipfilter.dat >ipfilter0.dat
del /f /q ipfilter.dat >nul 2>nul
if not exist ipfilter1.dat (ren ipfilter0.dat ipfilter1.dat) else if not exist ipfilter2.dat (ren ipfilter0.dat ipfilter2.dat) else if not exist ipfilter3.dat (ren ipfilter0.dat ipfilter3.dat) else if not exist ipfilter4.dat (ren ipfilter0.dat ipfilter4.dat)
exit /b

:renaming
rem dir /a-d /b /l | findstr /v /c:"ipfilterdl.exe" | findstr /c:"p2p" >%myfiles%\file.tmp 2>nul
rem for /f "tokens=1" %%i in (%myfiles%\file.tmp) do (set "result=%%i")
rem del /f /q %myfiles%\file.tmp >nul 2>nul
cd %thrash%
for /f "tokens=1" %%i in ('%myfiles%\find.exe -maxdepth 1 -name *.*') do (set "res=%%i")
set result=%res:./=%
ren %result% your.file >nul 2>nul
cd ..
move /Y .\%thrash%\your.file .\  >nul 2>nul
rd /s /q %thrash%
if "%result%" equ "" exit /b 1
exit /b 0

:listparse
for /f "tokens=1" %%i in ('%myfiles%\grep -Ec "[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}\W*[-]\W*[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}\W*[,]\W*[0-9]{1,3}" your.file') do (set fileformat=%%i)
if "%fileformat%" neq "0" (ren your.file ipfilter.dat >nul 2>nul) else exit /b 1
exit /b 0

:decomment
echo off
(for /f "tokens=1,2 delims=," %%i in (%~1) do echo %%i , %%j ,) > %~2
exit /b

:dedupe
setlocal disableDelayedExpansion
set "file=%~1"
set "line=%file%.line"
set "deduped=%file%.deduped"
del /f /q %line% >nul 2>nul
del /f /q %deduped% >nul 2>nul
::Define a variable containing a linefeed character
set LF=^


::The 2 blank lines above are critical, do not remove
>"%deduped%" (
  for /f usebackq^ eol^=^%LF%%LF%^ delims^= %%A in ("%file%") do (
    set "ln=%%A"
    setlocal enableDelayedExpansion
    >"%line%" (echo !ln:\=\\!)
    >nul findstr /ilg:"%line%" "%deduped%" || (echo !ln!)
    endlocal
  )
)
>nul move /y "%deduped%" "%~n1_deduped%~x1"
del /f /q %line% >nul 2>nul
exit /b
