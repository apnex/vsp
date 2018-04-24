#!/bin/bash
source drv.core

#MOREF=$1
#if [ ! -z "$MOREF" ]; then
#	MOREF="/$1"
#fi

URL="https://$HOST/rest/vcenter/network"
printf "Retrieving [$URL]... " 1>&2
RESPONSE=$(curl -k -w "%{http_code}" -X GET \
-H "vmware-api-session-id: $SESSION" \
-H "Content-Type: application/json" \
"$URL" 2>/dev/null)
isSuccess "$RESPONSE"
echo "$HTTPBODY"

