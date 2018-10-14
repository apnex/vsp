#!/bin/bash
if [[ $0 =~ ^(.*)/([^/]+)$ ]]; then ## offload to drv.core?
	WORKDIR=${BASH_REMATCH[1]}
	if [[ ${BASH_REMATCH[2]} =~ ^[^.]+[.](.+)[.]sh$ ]]; then
		ITEM=${BASH_REMATCH[1]}
	fi
fi
source ${WORKDIR}/drv.core

## input driver
#INPUT=$(${WORKDIR}/drv.sddc.status.sh)
INPUT=$(${WORKDIR}/drv.sddc.test.sh)

## build record structure
read -r -d '' INPUTSPEC <<-CONFIG
	. | map({
		"type": .type,
		"hostname": .hostname,
		"online": .online,
		"dnsfwd": .dnsfwd,
		"dnsrev": .dnsrev,
		"ping": .ping,
		"thumbprint": .thumbprint
	})
CONFIG
PAYLOAD=$(echo "$INPUT" | jq -r "$INPUTSPEC")

## cache context data record
setContext "$PAYLOAD" "$ITEM"

## output
RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$INPUT" | jq --tab .
else
	buildTable "$PAYLOAD"
fi
