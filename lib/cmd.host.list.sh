#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.host.list.sh)
read -r -d '' JQSPEC <<-CONFIG
	(
		["host", "name", "connection_state", "power_state"]
		| ., map(length * "-")
	),(
		.value[] | [
			.host,
			.name,
			.connection_state,
			.power_state
		]
	) | @tsv
CONFIG

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
fi
