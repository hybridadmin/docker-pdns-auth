# PowerDNS Authoritative Docker Image
![Build](https://github.com/hybridadmin/docker-pdns-auth/workflows/Build/badge.svg?branch=main) ![Docker Pulls](https://img.shields.io/docker/pulls/hybridadmin/pdns-auth)

## Supported tags and respective `Dockerfile` links

- [`4.4.0`, `latest`](https://github.com/hybridadmin/docker-pdns-auth/tree/main/4.4.0/Dockerfile)
- [`4.3.0`](https://github.com/hybridadmin/docker-pdns-auth/tree/main/4.3.0/Dockerfile)

## What is PowerDNS Authoritative Nameserver ?

PowerDNS Authoritative Nameserver is a versatile nameserver which supports a large number of backends. These backends can either be plain zone files or be more dynamic in nature.
> [`doc.powerdns.com/authoritative`](https://doc.powerdns.com/authoritative/)

## How to use this image

### Standard usage

Run this container with the following command:

```console
docker run -d -p 53:53/udp -p 53:53/tcp -p 8081:8081/tcp --restart=always hybridadmin/pdns-auth:latest
```

To run older versions use the version tag for the required container image, i.e for version 4.3.0, run the following command:

```console
docker run -d -p 53:53/udp -p 53:53/tcp -p 8081:8081/tcp --restart=always hybridadmin/pdns-auth:4.3.0
```

To run the container with customized settings:
```
docker run -d --name tester00 \
-e IS_MASTER=yes `#optional` \
-e IS_SLAVE=no `#optional` \
-e ALLOW_AXFR_IPS=127.0.0.0/8,::1 `#optional` \
-e ALLOW_NOTIFY_FROM_IPS=0.0.0.0/0 `#optional` \
-e ALLOW_WEB_ACCESS=yes `#optional` \
-e WEBSERVER_PASSWORD=changemepass `#optional` \
-e ALLOW_API_ACCESS=yes `#optional` \
-e API_KEY=dfdfdfdf `#optional` \
-e DISABLE_AXFR=yes `#optional` \
-e DISABLE_SYSLOG=yes `#optional` \
-e DNAME_PROCESSING=no `#optional` \
-e EXPAND_ALIAS=no `#optional` \
-e USE_GUARDIAN=no `#optional` \
-e LOG_DNS_DETAILS=no `#optional` \
-e LOG_DNS_QUERIES=no `#optional` \
-e MAX_TCP_CONNECTION_DURATION=0 `#optional` \
-e MAX_TCP_CONNECTIONS=20 `#optional` \
-e QUERY_LOGGING=no `#optional` \
-e RECEIVER_THREADS=2 `#optional` \
-e RETRIEVAL_THREADS=2 `#optional` \
-e SIGNING_THREADS=2 `#optional` \
-p 53:53/udp -p 53:53/tcp -p 8081:8081/tcp --restart=always hybridadmin/pdns-auth:latest
```

To add a dns zone from outside the container:
```console
docker exec --tty [container_id] env TERM=xterm pdnsutil create-zone example.com
docker exec --tty [container_id] env TERM=xterm pdnsutil add-record example.com @ NS ns1.example.com
docker exec --tty [container_id] env TERM=xterm pdnsutil add-record example.com @ NS ns2.example.com
docker exec --tty [container_id] env TERM=xterm chown pdns -R /var/lib/powerdns
```

Connect to the container:
```console
docker exec -it [container_id] /bin/bash
```

### Configuration Settings

By default, the settings below will be configured in `/etc/powerdns/pdns.d/pdns.lmdb.conf`via the script [`docker-entrypoint.sh`](./docker-entrypoint.sh) inside the container.

Example `pdns.lmdb.conf`:
```
allow-axfr-ips=127.0.0.0/8,::1
allow-notify-from=0.0.0.0/0,::/0
api=yes
api-key=changemeapi
disable-axfr=yes
disable-syslog=yes
dname-processing=no
expand-alias=no
guardian=no
local-address=0.0.0.0
local-port=53
log-dns-details=no
log-dns-queries=no
setgid=pdns
setuid=pdns
loglevel=4
master=yes
max-tcp-connection-duration=0
max-tcp-connections=20
query-logging=yes
receiver-threads=1
resolver=no
retrieval-threads=2
reuseport=yes
signing-threads=3
slave=no
tcp-fast-open=0
version-string=Not-Supported
webserver=yes
webserver-address=0.0.0.0
webserver-allow-from=0.0.0.0/0
webserver-password=changemeweb
webserver-port=8081
launch=lmdb
lmdb-filename=/var/lib/powerdns/pdns.lmdb
lmdb-sync-mode=nometasync
```

> Note: The configuration above uses the [`lmdb backend`](https://doc.powerdns.com/authoritative/backends/lmdb.html#).

Additional settings from the official configuration [`documentation`](https://doc.powerdns.com/authoritative/settings.html) can be added as well if needed.
