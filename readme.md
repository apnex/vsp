## Scripts for vCenter REST API

#### 1: Ensure you have prerequisites installed
Ensure you meet the prerequisites on linux to execute to scripts.
Currently, these have been tested on Linux.

##### Centos
```shell
yum install curl jq bind-utils
```

##### Ubuntu
```shell
apt-get install curl jq bind-utils
```

##### Mac OSX
Install brew
```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
```

Install curl & jq
```shell
brew install curl jq
```

#### 2: Clone repository from GitHub
Perform the following command to download the scripts - this will create a directory `vsp` on your local machine
```shell
git clone https://github.com/apnex/vsp
```

#### 3: Set up SDDC parameters
Modify the `sddc.parameters` file to reflect the parameters for your lab.
Configure the vCenter `endpoint` as appropriate.
Connection attempts will be made to a concatenation of `hostname`.`domain` - or simply `hostname` if `hostname` is an IP address

```json
{
	"dns": "172.16.0.1",
	"domain": "lab",
	"endpoints": [
		{
			"type": "vsp",
			"hostname": "vcenter",
			"username": "administrator@vsphere.local",
			"password": "VMware1!",
			"online": "true"
		}
	]
}
```

#### 4: Profit!
Execute individual scripts as required.
For all `list` commands below, the `json` optional parameter can be added to see raw JSON output instead.
i.e `./vm.list.sh json` will bypass table formatting and show raw JSON for vms. 

##### vm.list: List vms
```shell
./cmd.vm.list.sh [json]
```

##### vm.start: Start vm
```shell
./cmd.vm.start.sh <vm-id>
# example
./cmd.vm.start.sh vm-102
```

##### vm.stop: Stop vm
```shell
./cmd.vm.stop.sh <vm-id>
# example
./cmd.vm.stop.sh vm-102
```

##### vm.create: Create vm
```shell
./cmd.vm.create.sh <vm-spec-json>
# example
./cmd.vm.create.sh spec.vm.test01.json
```

##### vm.delete: Delete vm
```shell
./cmd.vm.delete.sh <vm-id>
# example
./cmd.vm.delete.sh vm-102
```

##### datastore.list: List datastores
```shell
./cmd.datastore.list.sh [json]
```

##### vm.list: List networks
```shell
./cmd.network.list.sh [json]
```

##### host.list: List hosts
```shell
./cmd.host.list.sh [json]
```

##### cluster.list: List clusters
```shell
./cmd.cluster.list.sh [json]
```
