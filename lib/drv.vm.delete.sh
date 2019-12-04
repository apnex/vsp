#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.vsp.client

# define inputs
INPUTS=("${@}")
NAMES=()
NAMES+=("vm.list")

# check all inputs are present and not null
BADARGS=0
for IDX in ${!NAMES[@]}; do
	ITEM="${INPUTS[${IDX}]}"
	if [[ -z $ITEM || $ITEM == null ]]; then
		BADARGS=1
	fi
done

# obtain individual key/value
function getValue() {
	local KEY="${1}"; shift
	local ARR=("${@}")
	local ITEM
	for IDX in ${!NAMES[@]}; do
		if [[ "${KEY}" == "${NAMES[${IDX}]}" ]]; then
			ITEM="${ARR[${IDX}]}"
		fi
	done
	printf "%s\n" "${ITEM}"
}

# set paramaters and execute
ID=$(getValue "vm.list" "${INPUTS[@]}")
ITEM="vm"
if [[ "${BADARGS}" == 0 ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		CALL="/${ID}"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.stop")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vspDelete "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.stop") $(ccyan "<vm.id>")\n" 1>&2
fi
