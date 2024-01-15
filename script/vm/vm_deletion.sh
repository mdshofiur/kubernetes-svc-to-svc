#!/bin/bash



echo "Deleting vm..."

INSTANCE_ID=$(cat vm/public_vm_id.txt)

aws ec2 terminate-instances \
    --instance-ids ${INSTANCE_ID} \
    --output text \
    --query 'TerminatingInstances[0].CurrentState.Name' \
    --no-cli-pager

echo "vm deleted successfully!"