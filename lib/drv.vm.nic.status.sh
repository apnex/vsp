#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vsp.client

## input driver
ID=${1}
NODES=$(${WORKDIR}/drv.vm.hardware.nic.list.sh "${ID}")

# re-base to drv.vm....?
# this aggreagation driver should not directly call vsp.client
function getStatus {
	local ID=${1}
	local NIC=${2}
	ITEM="vm"
	CALL="/${ID}/hardware/ethernet/${NIC}"
	URL=$(buildURL "${ITEM}${CALL}")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.hardware.nic.list")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
		vspGet "${URL}"
	fi
}

function buildNode {
	local KEY=${1}

	# build node record
	local NIC=$(${WORKDIR}/drv.vm.hardware.ethernet.list.sh "${ID}" "${KEY}")
	read -r -d '' NODESPEC <<-CONFIG
		.value |
		{
			"id": "${KEY}",
			"name": .label,
			"start_connected": .start_connected,
			"backing_type": .backing.type,
			"backing_network": .backing.network
		}
	CONFIG
	local NEWNODE=$(echo "${NIC}" | jq -r "${NODESPEC}")

	## get node status
	#RESULT=$(getStatus "$KEY")
	#read -r -d '' STATUSSPEC <<-CONFIG
	#	{
	#		"status": .host_node_deployment_status,
	#		"version": .software_version
	#	}
	#CONFIG
	#NEWSTAT=$(echo "${RESULT}" | jq -r "${STATUSSPEC}")

	# merge node and status
	#MYNODE="$(echo "${NEWNODE}${NEWSTAT}" | jq -s '. | add')"
	printf "%s\n" "${NEWNODE}"
}

FINAL="[]"
for KEY in $(echo ${NODES} | jq -r '.value[] | .nic'); do
	MYNODE=$(buildNode "${KEY}")
	FINAL="$(echo "${FINAL}[${MYNODE}]" | jq -s '. | add')"
done
printf "${FINAL}" | jq --tab .
