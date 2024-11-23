#!/bin/sh
#
# ISC DHCPd 4.x for Windows patch
#	(C)2016-2024 Hikaru Yamatohimemiya
#	http://xprj.org/
#

main(){
	local SELF="${BASH_SOURCE:-${0}}";
	SELF=`readlink -f "${SELF}" || echo "${SELF}"`;
	local sRoot="${SELF%/*}";
	local sName="${SELF##*/}";
	
	local BUILD_DIR="${sRoot}/Build";
	local SRC_DIR="${sRoot}/../";
	local DST_DIR="${sRoot}/Release";
	
	local W_CFLAGS="-DDHCP_WINDOWS -fPIC -O2 -I${BUILD_DIR}/includes -I${sRoot}/../includes -I${sRoot}";
	local W_LDFLAGS="${BUILD_DIR}/VirtualFunctions.o"

	[ "${DHCP_BUILD:-0}" = '0' ] && {
		echo "Run 'Build.cmd'"
		return 1;
	}

	mkdir -p "${BUILD_DIR}"
	cd "${BUILD_DIR}" || return ${?};

	[ ! -e 'Makefile' ] && {
		"${SRC_DIR}/configure" \
			--prefix=/usr \
			--cache-file="${BUILD_DIR}/Config.cache" \
			|| return ${?};
	}

	[ ! -e "VirtualFunctions.o" ] && {
		gcc -c "${sRoot}/VirtualFunctions.c" -o "VirtualFunctions.o" ${W_CFLAGS} || return ${?};
	}
	
	make CFLAGS="${W_CFLAGS}" LDFLAGS="${W_LDFLAGS}" "${@}" || return ${?};
	
	make install prefix= DESTDIR="${DST_DIR}" || return ${?};
	
	return 0;
}

startup(){
	local R=0;
	main "${@}" || {
		R=${?};
		echo E: Build failed: ${R}
		return ${R};
	}
	return 0;
}
startup "${@}"

