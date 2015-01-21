#!/bin/bash

mkdir /data/data
mkdir /data/log
mkdir /data/etc

ES_CONFIG=/data/etc/elasticsearch-$ES_CLUSTER_NAME.yml
cp /etc/elasticsearch/elasticsearch.yml $ES_CONFIG

cat >> $ES_CONFIG << EOF
cluster:
  name: $ES_CLUSTER_NAME
EOF

if [ "$ES_DISCOVERY" == "ec2" ] ; then
	cat >> $ES_CONFIG << EOF
network:
  publish_host: _ec2_

cloud:
  aws:
    region: $ES_AWS_REGION

discovery:
  type: ec2
  ec2:
    groups: $ES_EC2_GROUPS
EOF
fi
