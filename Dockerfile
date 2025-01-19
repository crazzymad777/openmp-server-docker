# Use 32-bit debian
ARG BASE_IMAGE=i386/debian:bookworm-slim
FROM $BASE_IMAGE

# Install curl & xxd
RUN apt-get update && apt-get install -y wget && apt-get install -y xxd

# Custom version
ARG SAMP_VERSION=037svr_R3

# Just archive name
ARG TAR_GZ_ARCHIVE=samp${SAMP_VERSION}.tar.gz

# Set working directory
WORKDIR /srv/samp${SAMP_VERSION}

ARG SOURCE_URL=https://github.com/Se8870/SAMP-File-Archive/blob/master/archives/

# Download tar,gz
RUN wget -O /tmp/${TAR_GZ_ARCHIVE} $SOURCE_URL${TAR_GZ_ARCHIVE}?raw=true

# Envs
ENV SAMP_SERVER_DIR /srv/samp${SAMP_VERSION}
ENV SAMP_VERSION $SAMP_VERSION

# Unpack it
RUN tar -xvf /tmp/${TAR_GZ_ARCHIVE} --strip-components=1 -C $SAMP_SERVER_DIR
# Prepare server.cfg for running
RUN sed -i -e 's/rcon_password/#rcon_password/g' $SAMP_SERVER_DIR/server.cfg
RUN echo rcon_password `xxd -l16 -ps /dev/urandom` >> $SAMP_SERVER_DIR/server.cfg

# Expose default port
EXPOSE 7777/udp

# docker logs
RUN ln -sf /dev/stdout ${SAMP_SERVER_DIR}/server_log.txt

# Set entrypoint
ENTRYPOINT ${SAMP_SERVER_DIR}/samp03svr
