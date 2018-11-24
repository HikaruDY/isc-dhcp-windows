@echo off
pushd "%~dp0"
REM /*
REM // ISC DHCPd 4.x for Windows (with Cygwin) patch
REM //	(C)2016 Hikaru Kurosaki
REM //	http://xprj.org/
REM */

gcc -c VirtualFunction.c
IF NOT EXIST "VirtualFunction.o" call :ERR "Compile failed: VirtualFuncition.c"

pushd ..

	IF NOT EXIST "Makefile" sh configure
	IF NOT EXIST "Makefile" call :ERR "./configure failed."

	REM //Script directory
	set BASE=%~dp0
	set BASE=%BASE::=%
	set BASE=%BASE:\=/%
	set BASE=/cygdrive/%BASE%
	set DSTDIR=%BASE%/DHCP

	rd /s /q "%~dp0\DHCP"
	mkdir "%~dp0\DHCP"

 	make LDFLAGS="%~dp0\VirtualFunction.o" CFLAGS="-g -O2 -fno-strict-aliasing -I%BASE%/../includes -I%BASE%/../bind/include -I%BASE%" %* || GOTO ERR "Make failed"
	make install prefix="%DSTDIR%" || GOTO ERR "Install failed"

	echo "I: Build successful. Output directory is '%DSTDIR%'"

popd
popd

GOTO EOF
:ERR
echo E: %~1
exit /b 1
:EOF
exit /b 0
