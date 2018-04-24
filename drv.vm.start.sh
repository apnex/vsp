#!/bin/bash
source drv.core

VMID=$1

URL="https://$HOST/rest/vcenter/vm/$VMID/power/start"
curl -k -X POST \
-H "vmware-api-session-id: $SESSION" \
-H "Content-Type: application/json" \
"$URL"
