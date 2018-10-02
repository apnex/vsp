#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

VMID=${1}
${WORKDIR}/drv.vm.stop.sh ${VMID} | jq --tab .