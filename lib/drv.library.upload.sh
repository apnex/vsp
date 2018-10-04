#!/bin/bash
source drv.core
source drv.vsp.client

ISO_FILE="centos.iso"

URL=$1
SESSION="$(cat $VSPSESSION)"
echo "$VSPHOST"
echo "$SESSION"
echo "$URL"
FILE="${PWD}/centos.iso"

curl -vvv -k -X PUT \
	-F "centos.iso=@centos.iso" \
	-H "vmware-api-session-id: ${SESSION}" \
	"$URL"
