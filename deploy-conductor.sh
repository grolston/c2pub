#!/bin/bash
curl -o template.yml -L "https://rolston-cloud-library.s3.us-west-2.amazonaws.com/c2/conductor-account-support.yml"
aws cloudformation deploy --stack-name "aws-workshop-support" --template-file ./template.yml --capabilities "CAPABILITY_NAMED_IAM" "CAPABILITY_IAM"

vpc_id=$(aws ec2 describe-vpcs --query 'Vpcs[0].VpcId' --output text)

if [ -z "$vpc_id" ]; then
    echo "Failed to retrieve VPC ID."
    exit 1
fi

subnet_id=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpc_id" --query 'Subnets[0].SubnetId' --output text)

if [ -z "$subnet_id" ]; then
    echo "Failed to retrieve Subnet ID in the specified VPC."
    exit 1
fi

curl -o containment-template.yml -L "https://rolston-cloud-library.s3.us-west-2.amazonaws.com/c2/containment-score.yml"
aws cloudformation deploy --stack-name "containment-score" --template-file ./containment-template.yml --capabilities "CAPABILITY_NAMED_IAM" "CAPABILITY_IAM" --parameter-overrides pVpc=$vpc_id pSubnet=$subnet_id
