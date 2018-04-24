#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.cluster.list.sh)
read -r -d '' JQSPEC <<CONFIG
	.value |
		["cluster", "name", "drs_enabled", "ha_enabled"]
		,["-----", "-----", "-----", "-----"]
		,(.[] | [.cluster, .name, .drs_enabled, .ha_enabled])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
