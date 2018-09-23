#!/bin/bash
source drv.core
source drv.vsp.client

CLIENT_TOKEN=$(uuidgen)
printf "${CLIENT_TOKEN}\n" 1>&2
function makeBody {
	read -r -d '' BODY <<-CONFIG
	{
		"client_token": "$CLIENT_TOKEN",
		"create_spec": {
			"description": "test library",
			"name": "localLibrary",
			"storage_backings": [
				{
					"datastore_id": "datastore-11",
					"type": "DATASTORE"
				}
			],
			"type": "LOCAL"
		}
	}
	CONFIG
	printf "${BODY}"
}

VMSPEC=${1}
#if [[ -n "${VMSPEC}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		BODY=$(makeBody)
		ITEM="vm"
		CALL=""
		URL=$(buildURL "${ITEM}${CALL}")
		URL="https://${VSPHOST}/rest/com/vmware/content/local-library"
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "library.create")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}" "${BODY}"
		fi
	fi
#else
#	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.create") $(ccyan "<spec-name>")\n" 1>&2
#fi

