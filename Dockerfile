FROM dockerfile/elasticsearch

ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

RUN \
  cd /elasticsearch && \
  bin/plugin -i io.fabric8/elasticsearch-cloud-kubernetes/1.0.1 --verbose

EXPOSE 9200 9300
