#!/bin/bash

NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
INSTANCE_TYPE=t2.micro
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP_ID=sg-0bc993e0cecc501cb
DOMAIN_NAME=lakshman.tech

# if mysql or mongodb instance_type should be t3.medium , for all others it is t2.micro

for i in "${NAMES[@]}"
do  
    echo "creating $i instance"
    IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID  --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress')
    echo "created $i instance: $IP_ADDRESS"

    aws route53 change-resource-record-sets --hosted-zone-id Z05746793NAJYS3A68CN9 --change-batch '
    {
            "Changes": [{
            "Action": "UPDATE",
                        "ResourceRecordSet": {
                            "Name": "'$i.$DOMAIN_NAME'",
                            "Type": "A",
                            "TTL": 300,
                            "ResourceRecords": [{ "Value": "'$IP_ADDRESS'"}]
                        }}]
    }
    '
done