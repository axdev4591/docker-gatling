# Gatling is a highly capable load testing tool.
#
# Documentation: http://gatling.io/docs/2.0.0/
# Cheat sheet: http://gatling.io/#/cheat-sheet/2.0.0/

FROM denvazh/gatling:latest

LABEL maintainer = "devops4591@gmail.com"

# working directory for gatling
WORKDIR /opt

# gating version
#ENV GATLING_VERSION 2.2.5

# create directory for gatling install
RUN mkdir -p gatling


# change context to gatling directory
WORKDIR  /opt/gatling

# set directories below to be mountable from host
VOLUME ["/opt/gatling/conf", "/opt/gatling/results", "/opt/gatling/user-files"]

# set environment variables
ENV PATH /opt/gatling/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV GATLING_HOME /opt/gatling

ENTRYPOINT ["gatling.sh"]