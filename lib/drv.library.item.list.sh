#!/bin/bash
source drv.core
source drv.vsp.client

if [[ -n "${VSPHOST}" ]]; then
	ITEM="content"
	URL=$(buildURL "${ITEM}") #triggers session
	URL="https://${VSPHOST}/rest/com/vmware/content/library/item"
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vsp [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vspGet "${URL}"
	fi
fi
