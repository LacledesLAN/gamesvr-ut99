# escape=`
ARG CONTAINER_REGISTRY="docker.io"

FROM $CONTAINER_REGISTRY/lacledeslan/steamcmd:linux AS ut99-builder

ARG contentServer=content.lacledeslan.net

RUN echo "Downloading UT99 Dedicated Server Assets" &&`
        mkdir --parents /tmp/ &&`
        curl -sSL "http://${contentServer}/fastDownloads/_installers/ut99/ut99-server-469e-linux.tar.xz" -o /tmp/ut99-server.tar.xz &&`
    echo "Validating download against known hash" &&`
        echo "c7a249b4b0b7513abc77f58f3588eb80e3f2ca21900b5637e16dd3d7d1c21106 /tmp/ut99-server.tar.xz" | sha256sum -c - &&`
    echo "Extracting UT99 Dedicated Server Assets" &&`
        tar -xJvf /tmp/ut99-server.tar.xz -C /output/ &&`
        rm -f /tmp/*.xz

#=======================================================================
FROM debian:bookworm-slim

HEALTHCHECK NONE

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

RUN dpkg --add-architecture i386 &&`
    apt-get update && apt-get install -y `
        ca-certificates lib32z1 libsdl1.2debian:i386 locales locales-all tmux &&`
    apt-get clean &&`
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

ENV LANG=en_US.UTF-8 `
    LANGUAGE=en_US.UTF-8 `
    LC_ALL=en_US.UTF-8 `
    UT_DATA_PATH=/app/System

LABEL com.lacledeslan.build-node=$BUILDNODE `
        org.opencontainers.image.source=https://github.com/lacledeslan/gamesvr-ut99 `
        org.opencontainers.image.title="Unreal Tournament 99 Dedicated Server" `
        org.opencontainers.image.url=https://github.com/LacledesLAN/README.1ST `
        org.opencontainers.image.vendor="Laclede's LAN" `
        org.opencontainers.image.version=$SOURCE_COMMIT

# Set up Environment
RUN useradd --home /app --gid root --system UT99 &&`
    mkdir -p /app &&`
    chown UT99:root -R /app;

COPY --chown=UT99:root --from=ut99-builder /output /app

RUN chmod +x /app/ucc /app/System/ucc-bin

COPY --chown=UT99:root /dist.linux/ /app/

RUN chmod +x /app/ll-tests/*.sh

USER UT99

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
