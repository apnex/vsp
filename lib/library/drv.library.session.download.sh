#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.vsp.client

CLIENT_TOKEN=$(uuidgen)
printf "${CLIENT_TOKEN}\n" 1>&2

UPDATE_SESSION=$1
function makeBody {
	read -r -d '' BODY <<-CONFIG
	{
		"update_session_id": "${UPDATE_SESSION}",
		"file_spec": {
			"name": "centos.iso",
			"source_type": "PULL",
			"source_endpoint": {
				"uri": "http://pxe.apnex.io/centos.iso"
			}
		}
	}
	CONFIG
	printf "${BODY}"
}

#VMSPEC=${1}
ITEM="update-session"
#if [[ -n "${VMSPEC}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		BODY=$(makeBody)
		ITEM="update-session"
		CALL=""
		URL=$(buildURL "${ITEM}${CALL}")
		URL="https://${VSPHOST}/rest/com/vmware/content/library/item/updatesession/file/id:${UPDATE_SESSION}?~action=add"
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.create")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}" "${BODY}"
		fi
	fi
#else
#	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.create") $(ccyan "<spec-name>")\n" 1>&2
#fi
