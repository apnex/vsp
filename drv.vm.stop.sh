#!/bin/bash
source drv.core
source drv.vsp.client

ID=${1}
if [[ -n "${ID}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		ITEM="vm"
		CALL="/${ID}/power/stop"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.stop")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.stop") $(ccyan "<vm-id>")\n" 1>&2
fi

