/*
// ISC DHCPd 4.x for Windows (with Cygwin) patch
//	(C)2016 Hikaru Kurosaki
//	http://xprj.org/
*/

/*
	Add
		#include <WindowsDefine.h>
	to "includes/dhcpd.h" after [#include "config.h"]
	OR "includes/config.h" EOF
*/

#ifndef WINDOWS_DEFINE_H
#define WINDOWS_DEFINE_H

#define DHCP_WINDOWS
#undef __CYGWIN32__		//Do not use broken WinSock2 support (Provisional: Support WinSock2 for better performance in future version)

#undef TRACING			//Like as: configure --enable-tracing=no
#define USE_SOCKET_SEND 1	//Like as: configure --enable-use-sockets
#define USE_SOCKET_RECEIVE 1	//Like as: configure --enable-use-sockets
#define SO_BINDTODEVICE 1	//Windows: SO_BINDTODEVICE supported.

//Avoid compile error
//int errno;			//Do not use in current cygwin environment
#define EINVAL	22
#define ERANGE	34

#endif //WINDOWS_DEFINE_H
