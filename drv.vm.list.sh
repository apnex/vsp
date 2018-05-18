#!/bin/bash
source drv.core
source drv.vsp.client

VMID=${1}
if [[ -n "${VSPHOST}" ]]; then
	ITEM="vm"
	CALL="/${VMID}"
	URL=$(buildURL "${ITEM}${CALL}")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vsp [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vspGet "${URL}"
	fi
fi
