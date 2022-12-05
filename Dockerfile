# Gatling is a highly capable load testing tool.
#
# Documentation: http://gatling.io/docs/2.0.0/
# Cheat sheet: http://gatling.io/#/cheat-sheet/2.0.0/

FROM openjdk:8-jdk-alpine

LABEL maintainer = "devops4591@gmail.com"

# working directory for gatling
WORKDIR /opt

# gating version
ENV GATLING_VERSION 3.8.4

# create directory for gatling install
RUN mkdir -p gatling

# install gatling
RUN apk add --update wget bash && \
  mkdir -p /tmp/downloads && \
  wget -q -O /tmp/downloads/gatling-$GATLING_VERSION.zip \
  https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts/$GATLING_VERSION/gatling-charts-highcharts-$GATLING_VERSION-bundle.zip && \
  mkdir -p /tmp/archive && cd /tmp/archive && \
  unzip /tmp/downloads/gatling-$GATLING_VERSION.zip && \
  mv /tmp/archive/gatling-charts-highcharts-$GATLING_VERSION/* /opt/gatling/ && \
  rm -rf /tmp/*

# change context to gatling directory
WORKDIR  /opt/gatling

# set directories below to be mountable from host
VOLUME ["/opt/gatling/conf", "/opt/gatling/results", "/opt/gatling/user-files"]

# set environment variables
ENV PATH /opt/gatling/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV GATLING_HOME /opt/gatling

ENTRYPOINT ["gatling.sh"]