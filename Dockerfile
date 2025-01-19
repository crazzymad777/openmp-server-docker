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

# Labels
LABEL org.opencontainers.image.source "https://github.com/crazzymad777/samp-server-docker"
LABEL org.opencontainers.image.description "Source archive: $SOURCE_URL${TAR_GZ_ARCHIVE}"
LABEL org.opencontainers.image.licenses "https://github.com/crazzymad777/samp-server-docker/blob/master/license/SAMP_LICENSE.txt"

# Envs
ENV SAMP_SERVER_DIR /srv/samp${SAMP_VERSION}
ENV SAMP_VERSION $SAMP_VERSION

# Unpack it
RUN tar -xvf /tmp/${TAR_GZ_ARCHIVE} --strip-components=1 -C $SAMP_SERVER_DIR

# Lock server.cfg until first run
RUN bash -c 'mv ${SAMP_SERVER_DIR}/server.cfg{,.lock}'

# Copy entrypoint script
COPY ./entrypoint.sh /srv/

# Expose default port
EXPOSE 7777/udp

# docker logs
RUN ln -sf /dev/stdout ${SAMP_SERVER_DIR}/server_log.txt

# Set entrypoint
ENTRYPOINT /srv/entrypoint.sh
