## Info

Simple Dockerfile for SA:MP server software.


## Build image

```
docker build . -t samp-server:0.3.7-R3
```

## Run container

```
docker run -d -p 7777:7777/udp --name samp037 samp-server:0.3.7-R3
```
