#!/bin/bash
curl -o template.yml -L "https://raw.githubusercontent.com/grolston/c2pub/main/conductor.yml"
aws cloudformation deploy --stack-name "conductor" --template-file ./template.yml --capabilities CAPABILITY_NAME_IAM
