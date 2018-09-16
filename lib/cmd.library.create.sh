#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

SPEC=${1}
${WORKDIR}/drv.library.create.sh ${SPEC}
