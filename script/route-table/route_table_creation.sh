#!/bin/bash

AWS_REGION="us-east-1"
PUBLIC_SUBNET_ID=$(cat subnet/public_id.txt)
PRIVATE_SUBNET_ID=$(cat subnet/private_id.txt)
VPC_ID=$(cat vpc/vpc_id.txt)
IGW_ID=$(cat internet_gateway/gateway_id.txt)



# Create Route Table For Public Subnet...

echo "Create Route Table For Public Subnet..."

PUBLIC_ROUTE_TABLE_ID=$(aws ec2 create-route-table \
    --vpc-id "$VPC_ID" \
    --region "$AWS_REGION" \
    --output text \
    --query 'RouteTable.{RouteTableId:RouteTableId}' \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=my-public-route-table}]")

echo "Route Table for Public Subnet created successfully!"
# Save the PRIVATE_ROUTE_TABLE_ID to a text file
echo "$PRIVATE_ROUTE_TABLE_ID" > route-table/public_route_table_id.txt



echo "Associate Public Subnet with Route Table..."
echo "PUBLIC_SUBNET_ID: $PUBLIC_SUBNET_ID"

aws ec2 associate-route-table \
    --route-table-id "$PUBLIC_ROUTE_TABLE_ID" \
    --subnet-id "$PUBLIC_SUBNET_ID" \
    --region "$AWS_REGION" \
    --output text \
    --query 'AssociationId'

echo "Public Subnet associated with Route Table successfully!"



echo "Add Route Rule to Route Table and Internet Gateway assign..."

aws ec2 create-route \
    --route-table-id "$PUBLIC_ROUTE_TABLE_ID" \
    --destination-cidr-block '0.0.0.0/0' \
    --gateway-id "$IGW_ID" \
    --region "$AWS_REGION" \
    --output text \
    --query 'Return'

echo "Add Route Rule to Route Table and Internet Gateway assign successfully!"



# Create Route Table For Private Subnet...

echo "Create Route Table For Private Subnet..."

PRIVATE_ROUTE_TABLE_ID=$(aws ec2 create-route-table \
    --vpc-id "$VPC_ID" \
    --region "$AWS_REGION" \
    --output text \
    --query 'RouteTable.{RouteTableId:RouteTableId}' \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=my-private-route-table}]")

echo "Route Table for Private Subnet created successfully!"
# Save the PRIVATE_ROUTE_TABLE_ID to a text file
echo "$PRIVATE_ROUTE_TABLE_ID" > route-table/private_route_table_id.txt



echo "Associate Private Subnet with Route Table..."
echo "PRIVATE_SUBNET_ID: $PRIVATE_SUBNET_ID"

aws ec2 associate-route-table \
    --route-table-id "$PRIVATE_ROUTE_TABLE_ID" \
    --subnet-id "$PRIVATE_SUBNET_ID" \
    --region "$AWS_REGION" \
    --output text \
    --query 'AssociationId'

echo "Private Subnet associated with Route Table successfully!"


