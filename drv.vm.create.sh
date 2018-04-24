#!/bin/bash
source drv.core

SPEC=$1

URL="https://$HOST/rest/vcenter/vm"
printf "Retrieving [$URL]... " 1>&2
RESPONSE=$(curl -k -w "%{http_code}" -X POST \
-H "vmware-api-session-id: $SESSION" \
-H "Content-Type: application/json" \
-d @$SPEC \
"$URL" 2>/dev/null)
isSuccess "$RESPONSE"
echo "$HTTPBODY"
