## Info

Simple Dockerfile for SA:MP server software. This docker image can be used for running vanilla SA:MP server or can be base image for your server.

Inspired by https://github.com/krustowski/samp-server-docker

## How to use

Very simple approach to run vanilla server:
```
SAMP_VERSION=0.3.7-R3 ;
HOST_PORT=7777 ; 
docker container run -p$HOST_PORT:7777/udp ghcr.io/crazzymad777/samp-server:$SAMP_VERSION
```

