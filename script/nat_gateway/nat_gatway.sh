#!/bin/bash

NAT_GATEWAY_NAME="nat-gateway-1"
PRIVATE_ROUTE_TABLE_ID=$(cat route-table/private_route_table_id.txt)
PUBLIC_SUBNET_ID=$(cat subnet/public_id.txt)
PRIVATE_SUBNET_ID=$(cat subnet/private_id.txt)
NAT_GATEWAY_ID_SAVE=$(cat nat_gateway/nat_gateway_id.txt)


# Function to check command success and exit on failure
check_command() {
    if [ $? -eq 0 ]; then
        echo "Success: $1"
    else
        echo "Error: $1 failed"
        exit 1
    fi
}

# Allocate Elastic IP
echo "Allocating Elastic IP..."

EIP_ALLOCATION_ID=$(aws ec2 allocate-address \
    --domain vpc \
    --output text \
    --query 'AllocationId' \
    --no-cli-pager)

check_command "Elastic IP allocation"
#Save the EIP Allocation ID to a text file for later use in other scripts
echo "$EIP_ALLOCATION_ID" > nat_gateway/eip_allocation_id.txt

# Describe Elastic IP
echo "Describing Elastic IP..."

aws ec2 describe-addresses \
    --output text \
    --allocation-ids "${EIP_ALLOCATION_ID}" \
    --no-cli-pager

check_command "Elastic IP description"




# Create Nat Gateway
echo "Creating Nat Gateway..."

NAT_GATEWAY_ID=$(aws ec2 create-nat-gateway \
    --subnet-id "${PUBLIC_SUBNET_ID}" \
    --allocation-id "${EIP_ALLOCATION_ID}" \
    --tag-specifications "ResourceType=natgateway,Tags=[{Key=Name,Value=${NAT_GATEWAY_NAME}}]" \
    --output text \
    --query 'NatGateway.NatGatewayId' \
    --no-cli-pager)

check_command "Nat Gateway creation"
# Save the NAT Gateway ID to a text file for later use in other scripts
echo "$NAT_GATEWAY_ID" > nat_gateway/nat_gateway_id.txt



# Create Route
echo "Creating Route..."

aws ec2 create-route \
    --route-table-id "${PRIVATE_ROUTE_TABLE_ID}" \
    --destination-cidr-block '0.0.0.0/0' \
    --nat-gateway-id "${NAT_GATEWAY_ID_SAVE}"

check_command "Route creation"



# Describe Route Table
echo "Describing Route Table..."

aws ec2 describe-route-tables \
    --output text \
    --filter Name=route-table-id,Values="${PRIVATE_ROUTE_TABLE_ID}" \
    --route-table-ids "${PRIVATE_ROUTE_TABLE_ID}" 

check_command "Route Table description"

