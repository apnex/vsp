#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.cluster.list.sh)
read -r -d '' JQSPEC <<-CONFIG
	(
		["cluster", "name", "drs_enabled", "ha_enabled"]
		| ., map(length * "-")
	),(
		.value[] | [
			.cluster,
			.name,
			.drs_enabled,
			.ha_enabled
		]
	) | @tsv
CONFIG

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
fi
