#!/bin/bash
if [[ $(readlink -f $0) =~ ^(.*)/([^/]+)$ ]]; then
	WORKDIR="${BASH_REMATCH[1]}"
	CALLED="${BASH_REMATCH[2]}"
	if [[ ${CALLED} =~ ^[^.]+[.](.+)[.]sh$ ]]; then
		TYPE=${BASH_REMATCH[1]}
	fi
fi
LOCAL="0"
if [[ $0 =~ ^[.] ]]; then
	LOCAL="1"
fi
source ${WORKDIR}/mod.core

## inputs - learn from drv?
INPUTS=()
INPUTS+=("vm.list")

## build context data
function join_by { local IFS="${1}"; shift; echo "${*}"; }
STRING=$(join_by "|" "${INPUTS[@]}")
CONTEXT=$("${WORKDIR}"/cmd.context.list.sh "type:${STRING}" json)

## build args from context
MYARGS=()
for ITEM in ${INPUTS[@]}; do
	MYARGS+=($("${WORKDIR}"/cmd.context.list.sh "type:${ITEM}" json | jq -r .[0].id))
done

## output
FORMAT=${1}
case "${FORMAT}" in
	run)
		## call driver
		buildTable "${CONTEXT}"
		"${WORKDIR}/drv.${TYPE}.sh" "${MYARGS[@]}"
	;;
	*)
		## build context table
		printf "[$(cgreen "INFO")]: command usage: $(cgreen "${TYPE}") $(ccyan "[ run ]")\n" 1>&2
		buildTable "${CONTEXT}"
	;;
esac
