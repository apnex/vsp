#!/bin/bash
source drv.core
source drv.vsp.client
VMID=${1}

if [[ -n "${VMID}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		ITEM="vm"
		CALL="/${VMID}/power/start"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.start")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.start") $(ccyan "<vm-id>")\n" 1>&2
fi

