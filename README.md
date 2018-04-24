## Scripts for vCenter REST API

#### 1: Ensure you have JQ and CURL installed
Ensure you meet the pre-requisites on linux to execute to scripts.
Currently, these have been tested on Centos.

##### Centos
```shell
yum install curl jq
```

##### Ubuntu
```shell
apt-get install curl jq
```

#### 2: Clone repository from GitHub
Perform the following command to download the scripts - this will create a directory `vc` on your local machine
```shell
git clone https://github.com/apnex/vc
```

#### 3: Set up vCenter credentials
Modify the `vcsa-credentials` file to reflect the parameters for your lab.
I recommended using an FQDN of vcenter for the `hostname`.

```json
{
	"hostname": "vcenter.lab",
	"username": "administrator@vsphere.local",
	"password": "VMware1!",
	"domain": "lab"
}
```

#### 4: Profit!
Execute individual scripts as required.
For all `list` commands below, the `json` optional parameter can be added to see raw JSON output instead.
i.e `./vm.list.sh json` will bypass table formatting and show raw JSON for vms. 

##### vm.list: List vms
```shell
./vm.list.sh [json]
```

##### vm.start: Start vm
```shell
./vm.start.sh <vm-id>
# example
./vm.start.sh vm-102
```

##### vm.stop: Stop vm
```shell
./vm.stop.sh <vm-id>
# example
./vm.stop.sh vm-102
```

##### vm.create: Create vm
```shell
./vm.create.sh <vm-spec-json>
# example
./vm.create.sh spec.vm.test01.json
```

##### vm.delete: Delete vm
```shell
./vm.delete.sh <vm-id>
# example
./vm.delete.sh vm-102
```

##### datastore.list: List datastores
```shell
./datastore.list.sh [json]
```

##### vm.list: List networks
```shell
./network.list.sh [json]
```

##### host.list: List hosts
```shell
./host.list.sh [json]
```

##### cluster.list: List clusters
```shell
./cluster.list.sh [json]
```
