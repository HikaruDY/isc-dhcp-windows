#!/bin/sh

main(){
	local ROOT_DIR="${PWD}";
	local BUILD_DIR="${ROOT_DIR}/..";
	local SRC_DIR="${ROOT_DIR}/..";
	local DST_DIR="${ROOT_DIR}/DHCP";

	[ "${DHCP_BUILD:-0}" = '0' ] && {
		echo "Run 'Build.cmd'"
		return 1;
	}

	cd "${BUILD_DIR}" || return 1;

	gcc -c "${ROOT_DIR}/VirtualFunction.c" || {
		echo "Compile failed: VirtualFuncition.c"
		return 1;
	}

	[ ! -e 'Makefile' ] && {
		"${SRC_DIR}/configure"
	}

	[ ! -e 'Makefile' ] && {
		return 1;
	}

	make \
		LDFLAGS="${BUILD_DIR}/VirtualFunction.o" \
		CFLAGS="-DDHCP_WINDOWS -g -O2 -fno-strict-aliasing -I${SRC_DIR}/includes  -I${SRC_DIR} -I${SRC_DIR}/bind/include -I${ROOT_DIR}" \
		"${@}" \
	|| {
		echo "E: Build failed"
		return 1;
	}

	make install prefix="${DST_DIR}" || {
		echo "E: Install failed"
		return 1;
	}

#	echo "I: Build successful. Output directory is '%DSTDIR%'"


}

main "${@}"

