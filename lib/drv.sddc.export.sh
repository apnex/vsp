#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/mod.core

# export configuration for offline cli use
echo "Exporting all known specs - calling all list|status drivers..."

# rework to leverage drv.sddc.status?
if [[ "${NSXONLINE}" == "true" ]]; then
	printf "[$(cgreen "INFO")]: nsx [$(cgreen "online")]... [$(ccyan "TRUE")] - SUCCESS\n" 1>&2
	if [[ -f ${WORKDIR}/state ]]; then
		rm ${WORKDIR}/state/*json
	fi
else
	printf "[$(corange "WARN")]: nsx [$(cgreen "online")]... [$(ccyan "FALSE")] - SUCCESS\n" 1>&2
fi

for KEY in ${WORKDIR}/*; do
	if [[ "${KEY}" =~ drv[.].*[.](list|status)[.]sh ]]; then
		RUNFILE="${KEY}"
		eval ${RUNFILE} 1>/dev/null
	fi
done

echo "Export completed"

