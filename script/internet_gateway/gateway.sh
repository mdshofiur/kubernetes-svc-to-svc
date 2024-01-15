#!/bin/bash

AWS_REGION=$(cat vpc/aws_region.txt)
VPC_ID=$(cat vpc/vpc_id.txt)

# Create Internet Gateway
echo "Creating Internet Gateway..."

IGW_ID=$(aws ec2 create-internet-gateway \
    --region "$AWS_REGION" \
    --output text \
    --query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=create-my-igw}]")

echo "Internet Gateway created successfully!"

# Save the IGW_ID to a text file
echo "$IGW_ID" > internet_gateway/gateway_id.txt

# Attach Internet Gateway to VPC
echo "Attaching Internet Gateway to VPC..."

aws ec2 attach-internet-gateway \
    --internet-gateway-id "$IGW_ID" \
    --vpc-id "$VPC_ID" \
    --region "$AWS_REGION" \
    --output text \
    --query 'Return'

echo "Internet Gateway attached to VPC successfully!"
