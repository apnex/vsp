#!/bin/bash

#./cmd.vm.list.sh name:nsx,power_state:off
#./cmd.vm.start.sh run
#./cmd.vm.list.sh run

## start esx01
vsp-cli vm.list name:esx,power_state:off
vsp-cli vm.start run
