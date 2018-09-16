#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

SPECFILE=${1}
${WORKDIR}/drv.vm.create.sh $SPECFILE
