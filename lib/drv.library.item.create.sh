#!/bin/bash
source drv.core
source drv.vsp.client

CLIENT_TOKEN=$(uuidgen)
LIBRARY=${1}
printf "${CLIENT_TOKEN}\n" 1>&2
function makeBody {
	read -r -d '' BODY <<-CONFIG
	{
		"client_token": "$CLIENT_TOKEN",
		"create_spec": {
			"description": "a custom iso",
			"library_id": "${LIBRARY}",
			"name": "alpine-virt-3.7.0-x86_64.iso",
			"type": "iso"
		}
	}
	CONFIG
	printf "${BODY}"
}

VMSPEC=${1}
#if [[ -n "${VMSPEC}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		BODY=$(makeBody)
		ITEM="library.item"
		CALL=""
		URL=$(buildURL "${ITEM}${CALL}")
		URL="https://${VSPHOST}/rest/com/vmware/content/library/item"
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.create")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}" "${BODY}"
		fi
	fi
#else
#	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.create") $(ccyan "<spec-name>")\n" 1>&2
#fi

