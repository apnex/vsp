#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vsp.client

if [[ -n "${VSPHOST}" ]]; then
	ITEM="cluster"
	URL=$(buildURL "${ITEM}")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vsp [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vspGet "${URL}"
	fi
fi
