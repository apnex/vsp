#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.vm.list.sh)
# split header from data - 2 separate JQ passes
read -r -d '' JQSPEC <<-CONFIG
	[(
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
	)]
CONFIG

#get first record
CONTEXT=$(echo "$PAYLOAD" | jq -r "$JQSPEC" | jq --tab '.[2]')
echo "${CONTEXT}" >"${WORKDIR}/state/vsp.ctx.vm.json"

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC | .[] | @tsv" | sed 's/"//g' | column -t -s $'\t'
fi
