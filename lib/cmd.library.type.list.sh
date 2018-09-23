#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.library.type.list.sh)
read -r -d '' JQSPEC <<-CONFIG
	(
		["vendor", "name", "type", "version"]
		| ., map(length * "-")
	),(
		.value[] | [
			.vendor,
			.name,
			.type,
			.version
		]
	) | @tsv
CONFIG

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
fi
