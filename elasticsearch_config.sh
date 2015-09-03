#!/bin/bash

mkdir /data/data
mkdir /data/log
mkdir /data/etc
mkdir /data/work

ES_CONFIG=/data/etc/elasticsearch-$ES_CLUSTER_NAME.yml
cp /elasticsearch/config/elasticsearch.yml $ES_CONFIG

cat >> $ES_CONFIG << EOF
cluster:
  name: $ES_CLUSTER_NAME
EOF
