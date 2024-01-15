#!/bin/bash

echo "Describing All VMs..."

aws ec2 describe-instances \
    --query 'Reservations[*].Instances[*].[InstanceId,PublicIpAddress,PrivateIpAddress,State.Name,InstanceType]' \
    --output table \
    --no-cli-pager
echo "Complete Describe VM"
