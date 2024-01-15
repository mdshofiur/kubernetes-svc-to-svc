# Permissions: chmod +x makefile
# chmod +x vm_delete.sh


# Create VPC
create-vpc:
	@ ./vpc/create_vpc.sh

.PHONY: create-vpc




# internet-gateway-create
internet-gateway-create:
	@ ./internet_gateway/gateway.sh

.PHONY: internet-gateway-create


# subnet create
subnet-create:
	@ ./subnet/subnet_creation.sh

.PHONY: subnet-create



# Route Table Create

route-table-create:
	@ ./route-table/route_table_creation.sh

.PHONY: route-table-create


# Create Security Group
security-group-create:
	@ ./security_group/group.sh

.PHONY: security-group-create


# Create Key Pair
key-pair-create:
	@ ./pair_key/key_creation.sh

.PHONY: key-pair-create


# public Create VM
public_vm-create:
	@ ./vm/public_vm_creation.sh

.PHONY: public-vm-create

# private Create VM

private_vm-create:
	@ ./vm/private_vm_creation.sh

.PHONY: private_vm-create


# Delete VM
vm-delete:
	@ ./vm/vm_deletion.sh

.PHONY: vm-delete


# create disk for VM

disk-create:
	@ ./disk/disk_creation.sh

.PHONY: disk-create


# attach disk to VM

disk-attach:
	@ ./disk/disk_attach.sh

.PHONY: disk-attach


# Create NAT Gateway
nat-gatway-create:
	@ ./nat_gateway/nat_gatway.sh

.PHONY: nat-gatway-create

# Describe VM

describe_vm:
	@ ./vm/describe-vm.sh

.PHONY: describe_vm


# ALL Commands on at once

all: create-vpc internet-gateway-create subnet-create route-table-create security-group-create key-pair-create public_vm-create




