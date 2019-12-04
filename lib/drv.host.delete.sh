#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.vsp.client

ID=${1}
ITEM="host"
if [[ -n "${ID}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		CALL="/${ID}"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "delete")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
			vspDelete "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "logical-switches.delete") $(ccyan "<uuid>")\n" 1>&2
fi
