FROM dockerfile/elasticsearch

ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Install runit
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y supervisor && \
  apt-get autoremove -y && \
  apt-get autoclean

RUN \
  cd /elasticsearch && \
  bin/plugin install elasticsearch/elasticsearch-cloud-aws/2.4.1 && \
  bin/plugin -i io.fabric8/elasticsearch-cloud-kubernetes/1.0.1 --verbose

COPY elasticsearch_config.sh /opt/elasticsearch_config.sh
RUN chmod +x /opt/elasticsearch_config.sh

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9200 9300
