AWS_REGION=$(cat vpc/aws_region.txt)


echo "Creating Key Pair..."

# Create the key pair and capture the key material
KEY_MATERIAL=$(aws ec2 create-key-pair \
    --key-name access_pair \
    --key-format pem \
    --output text \
    --query 'KeyMaterial' \
    --region ${AWS_REGION})

echo "Key Pair created successfully!"
# Save the key material to a text file for later use in other scripts
echo "$KEY_MATERIAL" > pair_key/access_pair.pem
