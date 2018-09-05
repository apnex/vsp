#!/bin/bash
ID=${1}

if [[ -n "${ID}" ]]; then
	ssh root@${ID} <<-EOF
		shell \
		service-control --stop vmware-vapi-endpoint \
		service-control --start vmware-vapi-endpoint \
		service-control --status vmware-vapi-endpoint
	EOF
fi
