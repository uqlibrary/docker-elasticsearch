docker-elasticsearch
====================

This repository contains a Dockerfile of ElasticSearch for Docker's automated build published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download the [automated build](https://registry.hub.docker.com/u/uqlibrary/elasticsearch/) from the public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull uqlibrary/elasticsearch`

   (or, you can build an image from Dockerfile: `docker build -t uqlibrary/elasticsearch .)

### Usage

1. Create a mountable data directory `<data-dir>` on the host.

2. Start the container mounting the data directory:

    ```sh
    docker run -v <data-dir>:/data uqlibrary/elasticsearch
    ```

After few seconds, open `http://<host>:9200` to see the result.
