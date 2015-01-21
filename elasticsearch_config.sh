#!/bin/bash

ES_CONFIG=/data/etc/elasticsearch-$ES_CLUSTER_NAME.yml
cp /data/etc/elasticsearch.yml $ES_CONFIG

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
    access_key: $ES_AWS_KEY
    secret_key: $ES_AWS_SECRET

discovery:
  type: ec2
  ec2:
    groups: $ES_EC2_GROUPS
EOF
  if [ "$ES_S3_BUCKET" != "" ] ; then
      cat >> $ES_CONFIG << EOF
gateway:
  type: s3
  s3:
    bucket: $ES_S3_BUCKET
EOF
  fi
fi

if [ "$ES_AWS_REGION" != "" ] ; then
	cat >> $ES_CONFIG << EOF
cloud:
  aws:
    region: $ES_AWS_REGION
    access_key: $ES_AWS_KEY
    secret_key: $ES_AWS_SECRET
EOF
fi


