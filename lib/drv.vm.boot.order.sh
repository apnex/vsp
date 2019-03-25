#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vsp.client

function makeBody {
	read -r -d '' BODY <<-CONFIG
	{
		"devices": [
			{
				"type": "DISK",
				"disks": [
					"2000"
				]
			},
			{
				"type": "CDROM"
			},
			{
				"type": "ETHERNET",
				"nic": "4000"
			}
		]
	}
	CONFIG
	printf "${BODY}"
}

ID=${1}
if [[ -n "${ID}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		BODY=$(makeBody)
		ITEM="vm"
		CALL="/${ID}/hardware/boot/device"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.boot.order")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPut "${URL}" "${BODY}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.boot.order") $(ccyan "<vm-id>")\n" 1>&2
fi

