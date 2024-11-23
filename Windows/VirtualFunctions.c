/*
// ISC DHCPd 4.x for Windows patch
//	(C)2016-2024 Hikaru Yamatohimemiya
//	http://xprj.org/
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <dhcpd.h>

#define HW_TYPE_IPMP	255
#define HW_ADDR_LEN	20

void get_hw_addr(const char *name, struct hardware *hw){
	hw->hlen = sizeof(hw->hbuf);
	srandom( time(0) );

	hw->hbuf[0] = HW_TYPE_IPMP;
	for (int i = 1; i < hw->hlen; ++i) {
		hw->hbuf[i] = random() % 256;
	}

	return;
}
