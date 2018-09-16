#!/bin/bash
docker rm -f vsp-cli 2>/dev/null

# persist (run & exec)
#docker run -id --name vsp-cli -v ${PWD}/cfg:/cfg --entrypoint=/bin/sh apnex/vsp-cli
#docker exec -t vsp-cli vsp vm.list

# single (run)
docker run -it --rm -v ${PWD}/cfg:/cfg apnex/vsp-cli $1 $2
#docker run -it --rm -v ${PWD}/sddc.parameters:/cfg/sddc.parameters apnex/vsp-cli $1 $2
