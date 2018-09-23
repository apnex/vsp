#!/bin/bash
source drv.core
source drv.vsp.client

ISO_FILE="alpine-virt-3.7.0-x86_64.iso"
ISO_MD5=$(md5sum "${ISO_FILE}" | gawk '{print $1}')
ISO_SIZE=$(ls -l "${ISO_FILE}" | gawk '{print $5}')
URL=$1

#URL="https://vcenter.sddc-52-62-226-168.vmwarevmc.com:443/cls/data/214a1118-158c-4031-8985-2bfabbd811ed/alpine-virt-3.7.0-x86_64.iso"
SESSION="$(cat $VSPSESSION)"
echo "$VSPHOST"
echo "$SESSION"

curl -v -k -G -X PUT \
	-F "$ISO_FILE=@$ISO_FILE" \
	-H "vmware-api-session-id: ${SESSION}" \
	"$URL"
