#!/bin/bash
if [[ $0 =~ ^(.*)/([^/]+)$ ]]; then ## offload to drv.core?
	WORKDIR=${BASH_REMATCH[1]}
	if [[ ${BASH_REMATCH[2]} =~ ^[^.]+[.](.+)[.]sh$ ]]; then
		TYPE=${BASH_REMATCH[1]}
	fi
fi
source ${WORKDIR}/drv.core

## input driver
INPUT=$(${WORKDIR}/drv.folder.list.sh)

## build record structure
read -r -d '' INPUTSPEC <<-CONFIG
	.value | map({
		"id": .folder,
		"name": .name,
		"type": .type
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
