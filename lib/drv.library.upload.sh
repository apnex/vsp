#!/bin/bash
source drv.core
source drv.vsp.client

ISO_FILE="alpine-virt-3.7.0-x86_64.iso"
ISO_MD5=$(md5sum "${ISO_FILE}" | gawk '{print $1}')
ISO_SIZE=$(ls -l "${ISO_FILE}" | gawk '{print $5}')
LIBRARY_ITEM="46e06225-9fbc-4906-85d7-c08ed69232af"
UPDATE_SESSION="3beb707a-1518-48bd-a974-ecab805f526f:90a55320-9f98-4410-826d-922164501224"
URL=$1
#"https://vcenter.sddc-54-252-192-54.vmwarevmc.com:443/cls/data/c6500135-8ca5-4381-990a-0b8118f4c602/alpine-virt-3.7.0-x86_64.iso"

SESSION="$(cat $VSPSESSION)"
echo "$VSPHOST"
echo "$SESSION"

curl -v -k -X PUT \
	-F "$ISO_FILE=@$ISO_FILE" \
	-H "vmware-api-session-id: ${SESSION}" \
	"$URL"
