#!/bin/bash
source drv.core
source drv.vsp.client

if [[ -n "${VSPHOST}" ]]; then
	ITEM="cluster"
	URL=$(buildURL "${ITEM}")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vsp [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vspGet "${URL}"
	fi
fi
