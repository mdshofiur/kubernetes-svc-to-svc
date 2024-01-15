#!/bin/bash


# Public Subnet Creation Part :-

PUBLIC_SUBNET_CIDR="172.16.1.0/24"
AWS_REGION="us-east-1"
VPC_ID=$(cat vpc/vpc_id.txt)



echo "Creating Public Subnet..."

PUBLIC_SUBNET_ID=$(aws ec2 create-subnet \
    --vpc-id "$VPC_ID" \
    --cidr-block "$PUBLIC_SUBNET_CIDR" \
    --region "$AWS_REGION" \
    --output text \
    --query 'Subnet.{SubnetId:SubnetId}' > subnet/public_id.txt \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=my-public-subnet}]")

echo "Public Subnet created successfully!"



# Private Subnet Creation Part :-

PRIVATE_SUBNET_CIDR="172.16.2.0/24"


echo "Creating Private Subnet..."

PRIVATE_SUBNET_ID=$(aws ec2 create-subnet \
    --vpc-id "$VPC_ID" \
    --cidr-block "$PRIVATE_SUBNET_CIDR" \
    --region "$AWS_REGION" \
    --output text \
    --query 'Subnet.{SubnetId:SubnetId}' > subnet/private_id.txt \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=my-private-subnet}]")

echo "Private Subnet created successfully!"
echo "Public id ${PUBLIC_SUBNET_ID} and Private id ${PRIVATE_SUBNET_ID}"



