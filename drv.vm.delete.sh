#!/bin/bash
source drv.core

VMID=$1

URL="https://$HOST/rest/vcenter/vm/$VMID"
printf "Retrieving [$URL]... " 1>&2
RESPONSE=$(curl -k -w "%{http_code}" -X DELETE \
-H "vmware-api-session-id: $SESSION" \
-H "Content-Type: application/json" \
"$URL" 2>/dev/null)
isSuccess "$RESPONSE"
echo "$HTTPBODY"
