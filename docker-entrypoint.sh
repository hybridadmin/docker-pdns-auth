#!/bin/sh
set -e

PDNS_CONF="/etc/powerdns/pdns.d/pdns.lmdb.conf"

if [ "$1" = "pdns_server" ] && [ ! -f ${PDNS_CONF} ]; then
  echo "allow-axfr-ips=${ALLOW_AXFR_IPS:-127.0.0.0/8,::1}" >> ${PDNS_CONF}
  echo "allow-notify-from=${ALLOW_NOTIFY_FROM_IPS:-0.0.0.0/0,::/0}" >> ${PDNS_CONF}
  echo "api=${ALLOW_API_ACCESS:-yes}" >> ${PDNS_CONF}
  echo "api-key=${API_KEY:-changemeapi}" >> ${PDNS_CONF}
  echo "disable-axfr=${DISABLE_AXFR:-yes}" >> ${PDNS_CONF}
  echo "disable-syslog=${DISABLE_SYSLOG:-yes}" >> ${PDNS_CONF}
  echo "dname-processing=${DNAME_PROCESSING:-no}" >> ${PDNS_CONF}
  echo "expand-alias=${EXPAND_ALIAS:-no}" >> ${PDNS_CONF}
  echo "guardian=${USE_GUARDIAN:-no}" >> ${PDNS_CONF}
  echo "local-address=0.0.0.0" >> ${PDNS_CONF}
  echo "local-port=53" >> ${PDNS_CONF}
  echo "log-dns-details=${LOG_DNS_DETAILS:-no}" >> ${PDNS_CONF}
  echo "log-dns-queries=${LOG_DNS_QUERIES:-no}" >> ${PDNS_CONF}
  echo "setgid=pdns" >> ${PDNS_CONF}
  echo "setuid=pdns" >> ${PDNS_CONF}
  echo "loglevel=4" >> ${PDNS_CONF}
  echo "master=${IS_MASTER:-yes}" >> ${PDNS_CONF}
  echo "max-tcp-connection-duration=${MAX_TCP_CONNECTION_DURATION:-0}" >> ${PDNS_CONF}
  echo "max-tcp-connections=${MAX_TCP_CONNECTIONS:-20}" >> ${PDNS_CONF}
  echo "query-logging=${QUERY_LOGGING:-yes}" >> ${PDNS_CONF}
  echo "receiver-threads=${RECEIVER_THREADS:-1}" >> ${PDNS_CONF}
  echo "resolver=no" >> ${PDNS_CONF}
  echo "retrieval-threads=${RETRIEVAL_THREADS:-2}" >> ${PDNS_CONF}
  echo "reuseport=yes" >> ${PDNS_CONF}
  echo "signing-threads=${SIGNING_THREADS:-3}" >> ${PDNS_CONF}
  echo "slave=${IS_SLAVE:-no}" >> ${PDNS_CONF}
  echo "tcp-fast-open=0" >> ${PDNS_CONF}
  echo "version-string=Not-Supported" >> ${PDNS_CONF}
  echo "webserver=${ALLOW_WEB_ACCESS:-yes}" >> ${PDNS_CONF}
  echo "webserver-address=0.0.0.0" >> ${PDNS_CONF}
  echo "webserver-allow-from=0.0.0.0/0" >> ${PDNS_CONF}
  echo "webserver-password=${WEBSERVER_PASSWORD:-changemeweb}" >> ${PDNS_CONF}
  echo "webserver-port=8081" >> ${PDNS_CONF}
  echo "launch=lmdb" >> ${PDNS_CONF}
  echo "lmdb-filename=/var/lib/powerdns/pdns.lmdb" >> ${PDNS_CONF}
  echo "lmdb-sync-mode=nometasync" >> ${PDNS_CONF}
fi

exec "$@"
