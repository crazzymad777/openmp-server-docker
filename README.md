## Info

Simple docker image


## Build image

```
docker build . -t samp037svr_r3
```

## Run container

```
docker run -d -p 7777:7777/udp --name samp037 samp037svr_r3
```
