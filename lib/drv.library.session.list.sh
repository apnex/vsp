#!/bin/bash
source drv.core
source drv.vsp.client

CLIENT_TOKEN=$(uuidgen)
printf "${CLIENT_TOKEN}\n" 1>&2

UPDATE_SESSION=${1}
#if [[ -n "${VMSPEC}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		ITEM="update-session"
		URL="https://${VSPHOST}/rest/com/vmware/content/library/item/update-session/id:${UPDATE_SESSION}"
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.create")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspGet "${URL}"
		fi
	fi
#else
#	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.create") $(ccyan "<spec-name>")\n" 1>&2
#fi

