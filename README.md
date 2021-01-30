# PowerDNS Authoritative Docker Image


## Supported tags and respective `Dockerfile` links

- [`4.4.0`, `latest`](https://github.com/hybridadmin/docker-pdns-auth/tree/main/4.4.0/Dockerfile)
- [`4.3.0`](https://github.com/hybridadmin/docker-pdns-auth/tree/main/4.3.0/Dockerfile)

## What is PowerDNS Authoritative Nameserver ?

PowerDNS Authoritative Nameserver is a versatile nameserver which supports a large number of backends. These backends can either be plain zone files or be more dynamic in nature.
> [doc.powerdns.com/authoritative](https://doc.powerdns.com/authoritative/)

## How to use this image

### Standard usage

Run this container with the following command:

```console
docker run -d -p 53:53/udp -p 53:53/tcp --restart=always hybridadmin/pdns-auth:latest
```

To run older versions use the version tag for the required container image, i.e for version 4.3.0, run the following command:

```console
docker run -d -p 53:53/udp -p 53:53/tcp --restart=always hybridadmin/pdns-auth:4.3.0
```

To add a dns zone from outside the container:
```console
docker exec --tty [container_id] env TERM=xterm pdnsutil create-zone texample.com
docker exec --tty [container_id] env TERM=xterm pdnsutil add-record example.com @ NS ns1.texample.com
docker exec --tty [container_id] env TERM=xterm pdnsutil add-record example.com @ NS ns2.texample.com
docker exec --tty [container_id] env TERM=xterm chown pdns -R /var/lib/powerdns
``` 

Connect to the container:
```console
docker exec -it [container_id] /bin/bash
```

### Configuration Settings

By default, the settings below have been configured in /etc/powerdns/recursor.conf inside the container.

Example `recursor.conf`:
```
    local-address=0.0.0.0
    allow-from=0.0.0.0/0
    version-string=Not Supported
    setuid=daemon
    setgid=daemon
    max-cache-ttl=28800
    max-negative-ttl=3600
    packetcache-ttl=3600
    gettag-needs-edns-options=yes
    use-incoming-edns-subnet=yes
    any-to-tcp=yes
    reuseport=yes
    socket-dir=/var/run
```

Additional settings from the official configuration documentation at https://doc.powerdns.com/recursor/settings.html can be added as well if needed.



# User feedback

## Documentation

Documentation fo PowerDNS Recursor is available on the [project's website](https://doc.powerdns.com/recursor/).
