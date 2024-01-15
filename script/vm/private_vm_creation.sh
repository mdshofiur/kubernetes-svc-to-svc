#!/bin/bash


VM_NAME="private-vm"
SECURITY_GROUP_ID=$(cat security_group/group_id.txt)
PRIVATE_SUBNET_ID=$(cat subnet/private_id.txt)


echo "Private vm creating..."

aws ec2 run-instances \
    --image-id ami-053b0d53c279acc90 \
    --count 1 \
    --instance-type t2.micro \
    --key-name access_pair \
    --security-group-ids ${SECURITY_GROUP_ID} \
    --subnet-id ${PRIVATE_SUBNET_ID} \
    --no-associate-public-ip-address \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${VM_NAME}}]" \
    --output text \
    --query 'Instances[0].InstanceId' > vm/private_vm_id.txt

echo "Private vm created successfully!"




