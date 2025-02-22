# Use 32-bit debian
ARG BASE_IMAGE=i386/debian:bookworm-slim
FROM $BASE_IMAGE

# Install curl
RUN apt-get update && apt-get install -y wget

# Custom version
ARG OPENMP_VERSION=v1.4.0.2779

# Just archive name
ARG TAR_GZ_ARCHIVE=open.mp-linux-x86.tar.gz

# Set working directory
WORKDIR /srv/openmp

ARG SOURCE_URL=https://github.com/openmultiplayer/open.mp/releases/download/${OPENMP_VERSION}/

# Download tar,gz
RUN wget -O /tmp/${TAR_GZ_ARCHIVE} $SOURCE_URL${TAR_GZ_ARCHIVE}?raw=true

# Labels
LABEL org.opencontainers.image.source "https://github.com/crazzymad777/openmp-server-docker"
LABEL org.opencontainers.image.description "Source archive: $SOURCE_URL${TAR_GZ_ARCHIVE}"
LABEL org.opencontainers.image.licenses "MPL-2.0"

# Envs
ENV OPENMP_SERVER_DIR /srv/openmp
ENV OPENMP_VERSION $OPENMP_VERSION

# Unpack it
RUN tar -xvf /tmp/${TAR_GZ_ARCHIVE} --strip-components=1 -C $OPENMP_SERVER_DIR

# Expose default port
EXPOSE 7777/udp

# docker logs
RUN ln -sf /dev/stdout ${OPENMP_SERVER_DIR}/log.txt

# Set entrypoint
ENTRYPOINT /srv/openmp/omp-server
