#!/bin/bash
source drv.core
source drv.vsp.client

CLIENT_TOKEN=$(uuidgen)
printf "${CLIENT_TOKEN}\n" 1>&2

UPDATE_SESSION=${1}
if [[ -n "${UPDATE_SESSION}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		ITEM="update-session"
		URL="https://${VSPHOST}/rest/com/vmware/content/library/item/update-session/id:${UPDATE_SESSION}?~action=complete"
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "session.complete")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspPost "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "session.complete") $(ccyan "<update-sesssion>")\n" 1>&2
fi

