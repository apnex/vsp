#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.datastore.list.sh)
read -r -d '' JQSPEC <<-CONFIG
	(
		["datastore", "name", "type", "free_space", "capacity"]
		| ., map(length * "-")
	),(
		.value[] | [
			.datastore,
			.name,
			.type,
			.free_space,
			.capacity
		]
	) | @tsv
CONFIG

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
fi
