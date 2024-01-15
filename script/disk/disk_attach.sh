DISK_ID=$(cat disk/disk_id.txt)
AWS_REGION=$(cat vpc/aws_region.txt)
INSTANCE_ID=$(cat vm/public_vm_id.txt)

# Attach Disk to Instance
echo "Attaching Disk to Instance..."

aws ec2 attach-volume \
    --volume-id "$DISK_ID" \
    --instance-id "$INSTANCE_ID" \
    --device /dev/sdf \
    --region "$AWS_REGION" \
    --output text \
    --query 'Return'

echo "Disk attached to Instance successfully!"