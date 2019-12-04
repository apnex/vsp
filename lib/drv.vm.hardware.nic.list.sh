#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.vsp.client

ID=${1}
ITEM="vm"
if [[ -n "${ID}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		CALL="/${ID}/hardware/ethernet"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.hardware.nic.list")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspGet "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.hardware.nic.list") $(ccyan "<vm-id>")\n" 1>&2
fi

