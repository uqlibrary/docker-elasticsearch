FROM centos:centos7

ADD elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch

RUN \
  yum update -y && \
  yum install -y epel-release && \
  yum install -y python-setuptools hostname inotify-tools && \
  yum install -y java-1.7.0-openjdk && \
  yum install -y elasticsearch && \
  yum clean all && \
  easy_install supervisor

RUN \
  cd /usr/share/elasticsearch && \
  bin/plugin -i elasticsearch/elasticsearch-cloud-aws/2.4.1 && \
  bin/plugin -i royrusso/elasticsearch-HQ

RUN usermod -u 1000 elasticsearch

ADD elasticsearch_config.sh /opt/elasticsearch_config.sh
RUN chmod +x /opt/elasticsearch_config.sh

ADD limits.conf /etc/security/limits.conf
ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/data"]
WORKDIR /data

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9200
EXPOSE 9300
