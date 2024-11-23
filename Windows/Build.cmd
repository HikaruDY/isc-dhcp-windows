@echo off
REM /*
REM // ISC DHCPd 4.x for Windows patch
REM //	(C)2016-2024 Hikaru Yamatohimemiya
REM //	http://xprj.org/
REM */

:MAIN
pushd "%~dp0"
	CALL :BUILD %*
popd
GOTO :EOF

:BUILD
	set DHCP_BUILD=1
	bash ./Build.sh %*
GOTO :EOF

:ERR
echo E: %~1
exit /b 1

:EOF
exit /b 0
