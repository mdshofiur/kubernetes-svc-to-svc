#!/bin/bash



INSTANCE_ID=$(cat vm/public_vm_id.txt)
AWS_REGION=$(cat vpc/aws_region.txt)



# VM Availability Zone

VM_AVAILABILITY_ZONE=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query 'Reservations[0].Instances[0].Placement.AvailabilityZone' \
    --region "$AWS_REGION" \
    --output text)

# Save the VM_AVAILABILITY_ZONE to a text file
echo "$VM_AVAILABILITY_ZONE" > disk/vm_availability_zone.txt


# Create Disk
echo "Creating Disk..."
  
DISK_ID=$(aws ec2 create-volume \
    --region "$AWS_REGION" \
    --availability-zone "$VM_AVAILABILITY_ZONE" \
    --output text \
    --query 'VolumeId' \
    --size 20 \
    --volume-type gp2 \
    --tag-specifications "ResourceType=volume,Tags=[{Key=Name,Value=my-disk}]")

echo "Disk created successfully!"
# Save the DISK_ID to a text file
echo "$DISK_ID" > disk/disk_id.txt



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






# Create Snapshot
# echo "Creating Snapshot..."

# SNAPSHOT_ID=$(aws ec2 create-snapshot \
#     --region "$AWS_REGION" \
#     --output text \
#     --query 'SnapshotId' \
#     --volume-id "$DISK_ID" \
#     --description "create-my-snapshot")


# echo "Snapshot created successfully!"
# # Save the SNAPSHOT_ID to a text file
# echo "$SNAPSHOT_ID" > disk/snapshot_id.txt


# # Create AMI

# echo "Creating AMI..."

# AMI_ID=$(aws ec2 create-image \
#     --region "$AWS_REGION" \
#     --output text \
#     --query 'ImageId' \
#     --instance-id "$INSTANCE_ID" \
#     --name "create-my-ami" \
#     --description "create-my-ami" \
#     --no-reboot)

# echo "AMI created successfully!"
