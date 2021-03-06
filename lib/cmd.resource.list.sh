#!/bin/bash
if [[ $0 =~ ^(.*)/([^/]+)$ ]]; then ## offload to mod.core?
	WORKDIR=${BASH_REMATCH[1]}
	if [[ ${BASH_REMATCH[2]} =~ ^[^.]+[.](.+)[.]sh$ ]]; then
		TYPE=${BASH_REMATCH[1]}
	fi
fi
source ${WORKDIR}/mod.core

## input driver
INPUT=$(${WORKDIR}/drv.resource.list.sh)

## build record structure
read -r -d '' INPUTSPEC <<-CONFIG
	.value | map({
		"id": .resource_pool,
		"name": .name
	})
CONFIG
PAYLOAD=$(echo "$INPUT" | jq -r "$INPUTSPEC")

## cache context data record
setContext "$PAYLOAD" "$TYPE"

## output
RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$INPUT" | jq --tab .
else
	buildTable "$PAYLOAD"
fi
