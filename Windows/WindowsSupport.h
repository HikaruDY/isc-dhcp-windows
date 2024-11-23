/*
// ISC DHCPd 4.x for Windows patch
//	(C)2016-2024 Hikaru Yamatohimemiya
//	http://xprj.org/
*/

#ifndef WINDOWS_SUPPORT_H
#define WINDOWS_SUPPORT_H

#if !defined(DHCP_WINDOWS)
#define DHCP_WINDOWS
#endif //DHCP_WINDOWS

#undef __CYGWIN32__		//Do not use broken WinSock2 support (Provisional: Support WinSock2 for better performance in future version)

#undef TRACING			//configure --enable-tracing=no
#define USE_SOCKET_SEND 1	//configure --enable-use-sockets
#define USE_SOCKET_RECEIVE 1	//configure --enable-use-sockets
#define SO_BINDTODEVICE 1	//Windows: SO_BINDTODEVICE supported.

//Avoid compile error
#define EINVAL	22
#define ERANGE	34

#endif //WINDOWS_SUPPORT_H
