ARG ES_VER=7.5.2

## plugin
FROM docker.io/maven:3-jdk-12-alpine AS plugin
ARG ES_VER

WORKDIR /es
RUN apk add --no-cache git
RUN git clone https://github.com/lior-k/fast-elasticsearch-vector-scoring.git plugin \
    --depth 1 --branch es-${ES_VER} && \
    cd plugin && \
    mvn package


## elasticsearch
FROM docker.elastic.co/elasticsearch/elasticsearch:${ES_VER}
ARG ES_VER

COPY --from=plugin /es/plugin/target/releases/elasticsearch-binary-vector-scoring-${ES_VER}.zip \
    /usr/share/elasticsearch/vector-scoring.zip

RUN ./bin/elasticsearch-plugin install file:///usr/share/elasticsearch/vector-scoring.zip