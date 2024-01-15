VPC_ID=$(cat vpc/vpc_id.txt)
AWS_REGION=$(cat vpc/aws_region.txt)


echo "Creating Security Group..."

SECURITY_GROUP_ID=$(aws ec2 create-security-group \
    --group-name my-security-group \
    --description "My security group" \
    --vpc-id "$VPC_ID" \
    --region "$AWS_REGION" \
    --output text \
    --query 'GroupId')

echo "Security Group created successfully!"
# Save the SECURITY_GROUP_ID to a text file for later use in other scripts 
echo "$SECURITY_GROUP_ID" > security_group/group_id.txt




echo "Creating Inbound Rules..."

aws ec2 authorize-security-group-ingress \
    --group-id ${SECURITY_GROUP_ID} \
    --ip-permissions \
        IpProtocol=tcp,FromPort=80,ToPort=80,IpRanges='[{CidrIp=0.0.0.0/0}]' \
        IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges='[{CidrIp=0.0.0.0/0}]' \
        IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges='[{CidrIp=0.0.0.0/0}]' \
    --no-cli-pager

echo "Inbound Rules created successfully!"




echo "Creating Outbound Rules..."

aws ec2 authorize-security-group-egress \
    --group-id ${SECURITY_GROUP_ID} \
    --ip-permissions \
        IpProtocol=tcp,FromPort=80,ToPort=80,IpRanges='[{CidrIp=0.0.0.0/0}]' \
        IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges='[{CidrIp=0.0.0.0/0}]' \
        IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges='[{CidrIp=0.0.0.0/0}]' \
    --no-cli-pager

echo "Outbound Rules created successfully!"