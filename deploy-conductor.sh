#!/bin/bash
curl -o template.yml -L "https://rolston-cloud-library.s3.us-west-2.amazonaws.com/c2/conductor-account-support.yml"
aws cloudformation deploy --stack-name "aws-workshop-support" --template-file ./template.yml --capabilities "CAPABILITY_NAMED_IAM" "CAPABILITY_IAM"
