@echo off
REM /*
REM // ISC DHCPd 4.x for Windows (with Cygwin) patch
REM //	(C)2016-2023 Hikaru Kurosaki
REM //	http://xprj.org/
REM */

:MAIN
pushd "%~dp0"
	CALL :BUILD %*
popd
GOTO :EOF



:BUILD
	setlocal
	set DHCP_BUILD=1
	bash ./Build.sh %*
	endlocal
GOTO :EOF

:ERR
echo E: %~1
exit /b 1
:EOF
exit /b 0
