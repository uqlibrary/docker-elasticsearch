FROM dockerfile/elasticsearch

RUN \
  cd /elasticsearch && \
  bin/plugin -i elasticsearch/elasticsearch-cloud-aws/2.4.1 && \
  bin/plugin -i io.fabric8/elasticsearch-cloud-kubernetes/1.0.1 --verbose

ADD elasticsearch_config.sh /opt/elasticsearch_config.sh
RUN chmod +x /opt/elasticsearch_config.sh

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9200 9300
