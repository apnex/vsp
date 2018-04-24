#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.network.list.sh)
read -r -d '' JQSPEC <<CONFIG
	.value |
		["name", "type", "network"]
		,["-----", "-----", "-----"]
		,(.[] | [.name, .type, .network])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
