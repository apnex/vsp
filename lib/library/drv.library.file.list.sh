#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.vsp.client

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

ITEM="content"
if [[ -n "${VSPHOST}" ]]; then
	URL=$(buildURL "${ITEM}") #triggers session
	URL="https://${VSPHOST}/rest/com/vmware/content/library/item/file?library_item_id=${1}"
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vsp [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vspGet "${URL}"
	fi
fi
