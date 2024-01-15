#!/bin/bash


VM_NAME="master"
SECURITY_GROUP_ID=$(cat security_group/group_id.txt)
PUBLIC_SUBNET_ID=$(cat subnet/public_id.txt)


echo "Public vm creating..."

aws ec2 run-instances \
    --image-id ami-053b0d53c279acc90 \
    --count 1 \
    --instance-type t2.micro \
    --key-name access_pair \
    --security-group-ids ${SECURITY_GROUP_ID} \
    --subnet-id ${PUBLIC_SUBNET_ID} \
    --associate-public-ip-address \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${VM_NAME}}]" \
    --output text \
    --query 'Instances[0].InstanceId' > vm/public_vm_id.txt 

echo "Public vm created successfully!"
