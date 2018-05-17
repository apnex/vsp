#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.sddc.status.sh)
read -r -d '' JQSPEC <<CONFIG
	.
		| ["type", "hostname", "online", "dnsfwd", "dnsrev", "ping", "thumbprint"]
		, ["-----", "-----", "-----", "-----", "-----", "-----", "-----"]
		, (.[] | [.type, .hostname, .online, .dnsfwd, .dnsrev, .ping, .thumbprint])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	printf "%s\n" "$PAYLOAD" | jq --tab .
else
	printf "%s\n" "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
