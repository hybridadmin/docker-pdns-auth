FROM debian:buster-slim as powerdns
LABEL maintainer="Tinashe Chikomo"

ENV NAME=pdns \
    PDNS_SERVER_VERSION=master \
    VERSION=1.1 \
    SUMMARY="${NAME} a versatile nameserver which supports a large number of backends. These backends can either be plain zone files or be more dynamic in nature." \
    DESCRIPTION="${NAME} a versatile nameserver which supports a large number of backends. These backends can either be plain zone files or be more dynamic in nature."

ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

LABEL summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="${NAME} ${PDNS_SERVER_VERSION}" \
      name="hybridadmin/${NAME}" \
      maintainer="Tinashe Chikomo"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qqy && apt-get install -qqy apt-utils sudo curl gnupg

ADD "${PDNS_SERVER_VERSION}/pdns.list" /etc/apt/sources.list.d/pdns.list

ADD "${PDNS_SERVER_VERSION}/pdns" /etc/apt/preferences.d/pdns

RUN curl https://repo.powerdns.com/CBC8B383-pub.asc -o /tmp/CBC8B383-pub.asc && \
    sudo apt-key add /tmp/CBC8B383-pub.asc  && \
    set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get update -qqy && apt-get install -yqq --no-install-recommends \
      pdns-server pdns-backend-lmdb lmdb-utils \
      ldnsutils \
    && mkdir -p /etc/powerdns/pdns.d /var/lib/powerdns

RUN chown pdns:pdns -R /var/lib/powerdns \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

ADD docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

RUN chmod a+x /usr/bin/docker-entrypoint.sh

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 8081/tcp

#VOLUME "/etc/powerdns/"
WORKDIR "/etc/powerdns/"

HEALTHCHECK CMD ["pdns_control", "rping", "||", "exit", "1"]
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["pdns_server"]
