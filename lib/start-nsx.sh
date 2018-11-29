#!/bin/bash

## start manager
vsp-cli vm.list name:manager,power_state:off
vsp-cli vm.start run

## start controller
vsp-cli vm.list name:controller,power_state:off
vsp-cli vm.start run

# start edge
vsp-cli vm.list name:edge,power_state:off
vsp-cli vm.start run

## list
vsp-cli vm.list
