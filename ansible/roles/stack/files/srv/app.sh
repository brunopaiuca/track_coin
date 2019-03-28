#!/bin/bash


sec=0

while [ $sec -lt 5 ]

  do

    EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
    EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
    ENVAPP=$(aws ssm get-parameter --name "track_coins_env" --region "$EC2_REGION" | jq '.Parameter.Value' | tr -d '"')
    TRACKCOIN_TOPIC_ARN=$(aws ssm get-parameter --name "track_coins_topic_endpoint" --region "$EC2_REGION" | jq '.Parameter.Value' | tr -d '"')
    MSG=$(sh /srv/coinbash/coinbash.sh -l btc | grep Bitc | awk '{printf "%s %s = %s USD 24h-change %s 7d-change %s", $5, $3, $4, $6, $7}')
    DATE=$(date +%Y/%m/%d:%H:%M)

    aws sns publish --topic-arn "$TRACKCOIN_TOPIC_ARN" --message "$DATE - $ENVAPP - $MSG" --region "$EC2_REGION"

    sec=$(date +%S)
    sleep 10

  done
