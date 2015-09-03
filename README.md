docker-elasticsearch
====================

This repository contains a Dockerfile of ElasticSearch for Docker's automated build published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download the [automated build](https://registry.hub.docker.com/u/uqlibrary/elasticsearch/) from the public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull uqlibrary/elasticsearch`

   (or, you can build an image from Dockerfile: `docker build -t uqlibrary/elasticsearch .)

### Usage

1. Create a mountable data directory `<data-dir>` on the host.

2. Start a container by mounting the data directory and specifying the cluster name as an environment variable:

    ```sh
    docker run -v <data-dir>:/data uqlibrary/elasticsearch
    ```

After few seconds, open `http://<host>:9200` to see the result.

The following environment variables can be used to configure the container:

    ES_CLUSTER_NAME     (REQUIRED) The name of the Elasticsearch cluster.
    ES_NODE_MASTER      (REQUIRED) Whether the node will be the master in the cluster. 
                        Setting to "true" makes this node the master.
    ES_NODE_DATA        (REQUIRED) Whether the node will be a data node in the cluster. 
                        Setting to "true" makes this a data node.
                            
    ES_DISCOVERY        The type of discovery to use with Elasticsearch, if not set will use 
                        multicast. Setting to "ec2" will enable ec2 discovery using 
                        ES_EC2_GROUPS in ES_AWS_REGION. Setting to "kubernetes" will 
                        enable kubernetes automatic discovery using the ES_KUBE_SELECTOR.
    ES_EC2_GROUPS       Either a comma separated list or array based list of (security) groups 
                        used for discovery.
    ES_AWS_REGION       AWS region to be used for discovery.
