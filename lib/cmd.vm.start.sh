#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

## dependencies
ITEM="vm.list"

ID=${1}

## check context
if [ -z "${ID}" ]; then
	CONTEXT="${WORKDIR}/state/ctx.${ITEM}.json"
	if [ -f "${CONTEXT}" ]; then
		ID=$(cat "${CONTEXT}" | jq -r ".id")
	fi
fi
echo $ID

${WORKDIR}/drv.vm.start.sh ${ID}
