#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.folder.list.sh)
read -r -d '' JQSPEC <<-CONFIG
	(
		["name", "type", "folder"]
		| ., map(length * "-")
	),(
		.value[] | [
			.name,
			.type,
			.folder
		]
	) | @tsv
CONFIG

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
fi
