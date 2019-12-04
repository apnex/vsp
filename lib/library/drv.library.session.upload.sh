#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.vsp.client

CLIENT_TOKEN=$(cat uuid)
printf "${CLIENT_TOKEN}\n" 1>&2

ISO_FILE="centos.iso"
ISO_MD5=$(md5sum "${ISO_FILE}" | gawk '{print $1}')
ISO_SIZE=$(ls -l "${ISO_FILE}" | gawk '{print $5}')

function makeBody {
	read -r -d '' BODY <<-CONFIG
	{
		"file_spec": {
			"checksum_info": {
				"algorithm": "MD5",
				"checksum": "${ISO_MD5}"
			},
			"name": "${ISO_FILE}",
			"size": "${ISO_SIZE}",
			"source_type": "PUSH"
		}
	}
	CONFIG
	printf "${BODY}"
	printf "${BODY}" 1>&2
}

UPDATE_SESSION=${1}
ITEM="update-session"
#if [[ -n "${VMSPEC}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		BODY=$(makeBody)
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

