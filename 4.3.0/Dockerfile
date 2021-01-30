FROM ubuntu:focal as powerdns
LABEL maintainer="Tinashe Chikomo"

ENV NAME=pdns \
    PDNS_SERVER_VERSION=4.3.0 \
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

RUN curl https://repo.powerdns.com/FD380FBB-pub.asc -o /tmp/FD380FBB-pub.asc && \
    sudo apt-key add /tmp/FD380FBB-pub.asc  && \
    set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get update -qqy && apt-get install -yqq --no-install-recommends \
      pdns-server pdns-backend-lmdb lmdb-utils \
      ldnsutils \
    && mkdir -p /etc/powerdns/pdns.d /var/lib/powerdns

ADD pdns.conf /etc/powerdns/pdns.d/pdns.lmdb.conf

RUN chown pdns:pdns -R /var/lib/powerdns \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 8081/tcp

#VOLUME "/etc/powerdns/"
WORKDIR "/etc/powerdns/"

HEALTHCHECK CMD ["pdns_control", "rping", "||", "exit", "1"]

CMD ["pdns_server"]
