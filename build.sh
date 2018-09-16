#!/bin/bash
docker rmi -f apnex/vsp-cli 2>/dev/null
docker build --no-cache -t apnex/vsp-cli -f alpine.dockerfile .
