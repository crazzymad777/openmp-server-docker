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

Example of child Dockerfile:
```
# Use base image
FROM ghcr.io/crazzymad777/samp-server:0.3.7-R3

# Clear gamemodes directory
RUN bash -c "rm $SAMP_SERVER_DIR/gamemodes/*"
# Clear filterscripts
RUN bash -c "rm $SAMP_SERVER_DIR/filterscripts/*"
# Copy own gamemode
COPY mysupergamemode.amx ./gamemodes/
# Copy own configuration
COPY mysuperconfig.cfg ./server.cfg.lock
```

Building docker image with:
```
docker build . -t mysuperserver
```

Create container and run:
```
ID=`docker container create -p7777:7777/udp mysuperserver` 
docker container start $ID 
```

