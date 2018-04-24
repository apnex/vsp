#!/bin/bash

VMID=$1
./drv.vm.stop.sh $VMID | jq --tab .
