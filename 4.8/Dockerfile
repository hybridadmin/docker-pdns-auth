FROM debian:bookworm-slim AS powerdns
LABEL maintainer="Tinashe Chikomo"

ENV NAME=pdns \
    PDNS_SERVER_VERSION=4.8 \
    VERSION=1.1 \
    SUMMARY="${NAME:-pdns} a versatile nameserver which supports a large number of backends. These backends can either be plain zone files or be more dynamic in nature." \
    DESCRIPTION="${NAME:-pdns} a versatile nameserver which supports a large number of backends. These backends can either be plain zone files or be more dynamic in nature."

ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

LABEL summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="${NAME:-pdns} ${PDNS_SERVER_VERSION}" \
      name="hybridadmin/${NAME:-pdns}" \
      maintainer="Tinashe Chikomo"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN set -x && DEBIAN_FRONTEND=noninteractive apt-get update -y && apt-get install -y apt-utils sudo curl gnupg2 && \
    echo "deb [signed-by=/etc/apt/keyrings/auth-48-pub.asc] http://repo.powerdns.com/debian bookworm-auth-48 main" | tee /etc/apt/sources.list.d/pdns.list && \
    printf "Package: pdns-*\nPin: origin repo.powerdns.com\nPin-Priority: 600" >> /etc/apt/preferences.d/auth-48 && \
    mkdir -p /etc/apt/keyrings && curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo tee /etc/apt/keyrings/auth-48-pub.asc && \
    apt-get update -y && apt-get install -y --no-install-recommends \
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
