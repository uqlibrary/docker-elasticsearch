FROM uqlibrary/docker-base

ENV ES_PKG_NAME elasticsearch-1.4.2

RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

COPY elasticsearch.yml /elasticsearch/config/elasticsearch.yml

RUN \
  cd /elasticsearch && \
  bin/plugin install elasticsearch/elasticsearch-cloud-aws/2.4.1 && \
  bin/plugin -i io.fabric8/elasticsearch-cloud-kubernetes/1.0.1

COPY elasticsearch_config.sh /opt/elasticsearch_config.sh
RUN chmod +x /opt/elasticsearch_config.sh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9200 9300
