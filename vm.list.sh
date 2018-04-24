#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.vm.list.sh)
read -r -d '' JQSPEC <<CONFIG
	.value |
		["vm", "power_state", "cpu_count", "memory_size_MiB", "name"]
		,["-----", "-----", "-----", "-----", "-----"]
		,(.[] | [.vm, .power_state, .cpu_count, .memory_size_MiB, .name])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
