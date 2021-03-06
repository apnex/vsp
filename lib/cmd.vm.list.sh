#!/bin/bash
if [[ $(readlink -f $0) =~ ^(.*)/([^/]+)$ ]]; then
	WORKDIR="${BASH_REMATCH[1]}"
	CALLED="${BASH_REMATCH[2]}"
	if [[ ${CALLED} =~ ^[^.]+[.](.+)[.]sh$ ]]; then
		TYPE=${BASH_REMATCH[1]}
	fi
fi
LOCAL="0"
if [[ $0 =~ ^[.] ]]; then
	LOCAL="1"
fi
source ${WORKDIR}/mod.core

## input driver
INPUT=$(${WORKDIR}/drv.vm.list.sh)

## build record structure
read -r -d '' INPUTSPEC <<-CONFIG
	.value | map({
		"id": .vm,
		"name": .name,
		"cpu_count": .cpu_count,
		"memory_size_MiB": .memory_size_MiB,
		"power_state": .power_state
	})
CONFIG
PAYLOAD=$(echo "$INPUT" | jq -r "$INPUTSPEC")

# build filter
FILTER=${1}
FORMAT=${2}
PAYLOAD=$(filter "${PAYLOAD}" "${FILTER}")

## cache context data record
setContext "$PAYLOAD" "$TYPE"

## output
case "${FORMAT}" in
	json)
		## build payload json
		echo "${PAYLOAD}" | jq --tab .
	;;
	raw)
		## build input json
		echo "${INPUT}" | jq --tab .
	;;
	*)
		## build payload table
		buildTable "${PAYLOAD}"
	;;
esac
