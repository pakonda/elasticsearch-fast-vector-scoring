FROM docker.elastic.co/elasticsearch/elasticsearch:7.5.2

COPY plugins/elasticsearch-binary-vector-scoring-7.5.2.zip /usr/share/elasticsearch/
RUN ./bin/elasticsearch-plugin install file:///usr/share/elasticsearch/elasticsearch-binary-vector-scoring-7.5.2.zip