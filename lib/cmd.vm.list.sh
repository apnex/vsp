#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.vm.list.sh)
read -r -d '' JQSPEC <<-CONFIG
	(
		["id", "name",  "cpu_count", "memory_size_MiB", "power_state"]
		| ., map(length * "-")
	),(
		.value[] | [
			.vm,
			.name,
			.cpu_count,
			.memory_size_MiB,
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
