#!/bin/bash

VPC_CIDR_BLOCK="172.16.0.0/16"
AWS_REGION="us-east-1"
VPC_NAME="master-vpc"

echo "Creating VPC..."

VPC_ID=$(aws ec2 create-vpc \
    --cidr-block "$VPC_CIDR_BLOCK" \
    --region "$AWS_REGION" \
    --output text \
    --query 'Vpc.{VpcId:VpcId}' > vpc/vpc_id.txt \
    --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=\"$VPC_NAME\"}]")

echo "VPC created successfully!"



# echo "Describe VPC..."

# aws ec2 describe-vpcs \
#     --region "$AWS_REGION" \
#     --query 'Vpcs[*].[VpcId, Tags[?Key==`Name`].Value | [0], IsDefault]' \
#     --output text \
# echo "VPC described successfully!"



# echo "Delete Default VPC..."

# aws ec2 delete-vpc \
#     --vpc-id "vpc-0f59ede229660fdae" \
#     --region "$AWS_REGION"

# echo "Default VPC deleted successfully!"
