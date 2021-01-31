#!/bin/sh
set -e

PDNS_CONF="/etc/powerdns/pdns.d/pdns.lmdb.conf"

if [ "$1" = "pdns_server" ] && [ ! -f ${PDNS_CONF} ]; then 
  echo "allow-axfr-ips=127.0.0.0/8,::1" >> ${PDNS_CONF}
  echo "allow-notify-from=0.0.0.0/0,::/0" >> ${PDNS_CONF}
  echo "api=yes" >> ${PDNS_CONF}
  echo "api-key=0ea254d8-6318-11eb-af75-00155d155af8" >> ${PDNS_CONF}
  echo "disable-axfr=yes" >> ${PDNS_CONF}
  echo "disable-syslog=yes" >> ${PDNS_CONF}
  echo "dname-processing=no" >> ${PDNS_CONF}
  echo "expand-alias=no" >> ${PDNS_CONF}
  echo "guardian=no" >> ${PDNS_CONF}
  echo "local-address=0.0.0.0" >> ${PDNS_CONF}
  echo "local-port=53" >> ${PDNS_CONF}
  echo "log-dns-details=no" >> ${PDNS_CONF}
  echo "log-dns-queries=no" >> ${PDNS_CONF}
  echo "setgid=pdns" >> ${PDNS_CONF}
  echo "setuid=pdns" >> ${PDNS_CONF}
  echo "loglevel=4" >> ${PDNS_CONF}
  echo "master=yes" >> ${PDNS_CONF}
  echo "max-tcp-connection-duration=0" >> ${PDNS_CONF}
  echo "max-tcp-connections=20" >> ${PDNS_CONF}
  echo "query-logging=yes" >> ${PDNS_CONF}
  echo "receiver-threads=1" >> ${PDNS_CONF}
  echo "resolver=no" >> ${PDNS_CONF}
  echo "retrieval-threads=2" >> ${PDNS_CONF}
  echo "reuseport=yes" >> ${PDNS_CONF}
  echo "signing-threads=3" >> ${PDNS_CONF}
  echo "slave=no" >> ${PDNS_CONF}
  echo "tcp-fast-open=0" >> ${PDNS_CONF}
  echo "version-string=Not-Supported" >> ${PDNS_CONF}
  echo "webserver=yes" >> ${PDNS_CONF}
  echo "webserver-address=0.0.0.0" >> ${PDNS_CONF}
  echo "webserver-allow-from=0.0.0.0/0" >> ${PDNS_CONF}
  echo "webserver-password=pdns000" >> ${PDNS_CONF}
  echo "webserver-port=8081" >> ${PDNS_CONF}
  echo "launch=lmdb" >> ${PDNS_CONF}
  echo "lmdb-filename=/var/lib/powerdns/pdns.lmdb" >> ${PDNS_CONF}
  echo "lmdb-sync-mode=nometasync" >> ${PDNS_CONF}
fi

exec "$@"
