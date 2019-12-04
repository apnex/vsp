#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.vsp.client

ITEM="content"
if [[ -n "${VSPHOST}" ]]; then
	URL=$(buildURL "${ITEM}") #triggers session
	URL="https://${VSPHOST}/rest/com/vmware/content/type"
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vsp [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vspGet "${URL}"
	fi
fi
