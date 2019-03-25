#!/bin/bash

## start manager
./cmd.vm.list.sh name:manager,power_state:off
./cmd.vm.start.sh run

## start controller
./cmd.vm.list.sh name:controller,power_state:off
./cmd.vm.start.sh run

# start edge
./cmd.vm.list.sh name:edge,power_state:off
./cmd.vm.start.sh run

## list
./cmd.vm.list.sh
