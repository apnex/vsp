#!/bin/bash
echo "Exporting all known [vsp] state..."

rm ./state/*json
read -r -d '' SPECS <<-CONFIG
	"drv.cluster.list.sh"
	"drv.datastore.list.sh"
	"drv.network.list.sh"
	"drv.host.list.sh"
	"drv.vm.list.sh"
CONFIG
for key in $(echo ${SPECS}); do
	RUNFILE="./${key}"
	eval ${RUNFILE} 1>/dev/null
done

echo "Export completed"

