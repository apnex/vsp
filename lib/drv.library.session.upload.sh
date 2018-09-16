#!/bin/bash
source drv.core
source drv.vsp.client

CLIENT_TOKEN=$(uuidgen)
printf "${CLIENT_TOKEN}\n" 1>&2

ISO_FILE="alpine-virt-3.7.0-x86_64.iso"
ISO_MD5=$(md5sum "${ISO_FILE}" | gawk '{print $1}')
ISO_SIZE=$(ls -l "${ISO_FILE}" | gawk '{print $5}')
LIBRARY_ITEM="46e06225-9fbc-4906-85d7-c08ed69232af"
UPDATE_SESSION=$1
#"3beb707a-1518-48bd-a974-ecab805f526f:90a55320-9f98-4410-826d-922164501224"

function makeBody {
	read -r -d '' BODY <<-CONFIG
	{
		"file_spec": {
			"checksum_info": {
				"algorithm": "MD5",
				"checksum": "${ISO_MD5}"
			},
			"name": "${ISO_FILE}",
			"size": ${ISO_SIZE},
			"source_type": "PUSH"
		}
	}
	CONFIG
	printf "${BODY}"
}

VMSPEC=${1}
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

