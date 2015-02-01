#!/bin/bash

mkdir /data/data
mkdir /data/log
mkdir /data/etc
mkdir /data/work

ES_CONFIG=/data/etc/elasticsearch-$ES_CLUSTER_NAME.yml
cp /data/elasticsearch.yml $ES_CONFIG

cat >> $ES_CONFIG << EOF
cluster:
  name: $ES_CLUSTER_NAME
EOF

if [ "$ES_DISCOVERY" == "ec2" ] ; then
	cat >> $ES_CONFIG << EOF
cloud:
  aws:
    region: $ES_AWS_REGION

discovery:
  type: ec2
  ec2:
    groups: $ES_EC2_GROUPS
  zen:
    ping:
      multicast:
        enabled: false

EOF
fi

if [ "$ES_DISCOVERY" == "kubernetes" ] ; then
	cat >> $ES_CONFIG << EOF
cloud:
  k8s:
    selector: $ES_KUBE_SELECTOR

discovery:
  type: io.fabric8.elasticsearch.discovery.k8s.K8sDiscoveryModule
  zen:
    ping:
      multicast:
        enabled: false

EOF
fi
