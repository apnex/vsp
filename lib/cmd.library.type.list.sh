#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.library.type.list.sh)
read -r -d '' JQSPEC <<-CONFIG
	(
		["vm", "power_state", "cpu_count", "memory_size_MiB", "name"]
		| ., map(length * "-")
	),(
		.value[] | [
			.vm,
			.power_state,
			.cpu_count,
			.memory_size_MiB,
			.name
		]
	) | @tsv
CONFIG

#RAW=${1}
RAW="json"
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
fi
