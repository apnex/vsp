#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vsp.client

ID=${1}
if [[ -n "${ID}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		ITEM="vm"
		CALL="/${ID}/power/start"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.start")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.start") $(ccyan "<vm-id>")\n" 1>&2
fi

