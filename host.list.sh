#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.host.list.sh)
read -r -d '' JQSPEC <<CONFIG
	.value |
		["host", "name", "connection_state", "power_state"]
		,["-----", "-----", "-----", "-----"]
		,(.[] | [.host, .name, .connection_state, .power_state])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
