FROM hg8496/atlassian-docker
MAINTAINER hg8496@cstolz.de

ENV BB_VERSION 4.12.1

RUN apt-get update \
  && apt-get install git -y \
  && curl -Lks  https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-${BB_VERSION}.tar.gz -o /bb.tar.gz \
  && mkdir -p /opt/bb \
  && tar zxf /bb.tar.gz --strip=1 -C /opt/bb \
  && chown -R atlassian:atlassian /opt/bb \
  && mv /opt/bb/conf/server.xml /opt/bb/conf/server-backup.xml \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /bb.tar.gz

ENV CONTEXT_PATH ROOT
ENV DATABASE_URL ""
ENV SSL_PROXY ""
ENV BITBUCKET_HOME /opt/atlassian-home

COPY launch.bash /launch

WORKDIR /opt/bb
VOLUME ["/opt/atlassian-home"]
EXPOSE 7990
EXPOSE 7999
USER atlassian
CMD ["/launch"]
