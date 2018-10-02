#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

FILEID=${1}
VM=${2}
${WORKDIR}/drv.vm.iso.mount.sh "$FILEID" "$VM"
