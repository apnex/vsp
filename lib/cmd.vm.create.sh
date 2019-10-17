#!/bin/bash
if [[ $(readlink -f $0) =~ ^(.*)/([^/]+)$ ]]; then
	WORKDIR="${BASH_REMATCH[1]}"
	CALLED="${BASH_REMATCH[2]}"
	if [[ ${CALLED} =~ ^[^.]+[.](.+)[.]sh$ ]]; then
		TYPE=${BASH_REMATCH[1]}
	fi
fi
LOCAL="0"
if [[ $0 =~ ^[.] ]]; then
	LOCAL="1"
fi

SPECFILE=${1}
${WORKDIR}/drv.vm.create.sh $SPECFILE
