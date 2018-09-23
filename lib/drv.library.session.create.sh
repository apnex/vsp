#!/bin/bash
source drv.core
source drv.vsp.client

CLIENT_TOKEN=$(uuidgen)
printf "${CLIENT_TOKEN}\n" 1>&2

ISO_FILE="alpine-virt-3.7.0-x86_64.iso"
ISO_MD5=$(md5sum "${ISO_FILE}" | gawk '{print $1}')
ISO_SIZE=$(ls -l "${ISO_FILE}" | gawk '{print $5}')
LIBRARY_ITEM=${1}

function makeBody {
	read -r -d '' BODY <<-CONFIG
	{
		"client_token": "${CLIENT_TOKEN}",
		"create_spec": {
			"library_item_id": "${LIBRARY_ITEM}"
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
		URL="https://${VSPHOST}/rest/com/vmware/content/library/item/update-session"
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.create")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}" "${BODY}"
		fi
	fi
#else
#	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.create") $(ccyan "<spec-name>")\n" 1>&2
#fi

