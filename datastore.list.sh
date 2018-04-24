#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.datastore.list.sh)
read -r -d '' JQSPEC <<CONFIG
	.value |
		["datastore", "name", "type", "free_space", "capacity"]
		,["-----", "-----", "-----", "-----", "-----"]
		,(.[] | [.datastore, .name, .type, .free_space, .capacity])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
