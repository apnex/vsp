#!/bin/bash
if [[ $0 =~ ^(.*)/([^/]+)$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
	if [[ ${BASH_REMATCH[2]} =~ ^[^.]+[.](.+)[.]sh$ ]]; then
		TYPE=${BASH_REMATCH[1]}
	fi
fi
source ${WORKDIR}/mod.core

## input driver
INPUT=$(${WORKDIR}/drv.context.list.sh)

## build record structure
read -r -d '' INPUTSPEC <<-CONFIG
	. | map({
		"id": .id,
		"name": .name,
		"type": .type
	})
CONFIG
PAYLOAD=$(echo "$INPUT" | jq -r "$INPUTSPEC")

# build filter structure
FILTER=${1}
FORMAT=${2}
PAYLOAD=$(filter "${PAYLOAD}" "${FILTER}")

## cache context data record
setContext "$PAYLOAD" "$TYPE"

## output
case "${FORMAT}" in
	json)
		echo "$PAYLOAD" | jq --tab .
	;;
	raw)
		echo "$INPUT" | jq --tab .
	;;
	*)
		buildTable "$PAYLOAD"
	;;
esac
