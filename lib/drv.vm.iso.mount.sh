#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vsp.client

function makeBody {
	read -r -d '' BODY <<-CONFIG
	{
		"vm": "${1}"
	}
	CONFIG
	printf "${BODY}"
}

LIBRARY=${1}
ID=${2}
if [[ -n "${ID}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		BODY=$(makeBody "${ID}")
		ITEM="vm"
		CALL=""
		URL=$(buildURL "${ITEM}${CALL}")
		URL="https://${VSPHOST}/rest/com/vmware/vcenter/iso/image/id:${LIBRARY}?~action=mount"
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.iso.mount")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}" "${BODY}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.create") $(ccyan "<spec-name>")\n" 1>&2
fi

