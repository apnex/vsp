#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vsp.client

ID=${1}
NIC=${2}
if [[ -n "${ID}" && "${NIC}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		ITEM="vm"
		CALL="/${ID}/hardware/ethernet/${NIC}"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.hardware.nic.list")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspGet "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.hardware.nic.list") $(ccyan "<vm-id> <nic-id>")\n" 1>&2
fi

