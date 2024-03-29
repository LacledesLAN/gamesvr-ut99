# escape=`
ARG CONTAINER_REGISTRY="docker.io"

FROM $CONTAINER_REGISTRY/lacledeslan/steamcmd:linux as ut99-builder

ARG contentServer=content.lacledeslan.net

RUN echo "Downloading UT99 Dedicated Server Assets" &&`
        mkdir --parents /tmp/ &&`
		curl -sSL "http://${contentServer}/fastDownloads/_installers/ut99-451-linux.7z" -o /tmp/ut99-server.7z &&`
    echo "Validating download against known hash" &&`
        echo "1f72326595e34474a955dfce7201c58ff16b772cb79ac118d3914d029b5e593e /tmp/ut99-server.7z" | sha256sum -c - &&`
	echo "Extracting UT99 Dedicated Server Assets" &&`
		7z x -o/output/ /tmp/ut99-server.7z &&`
		rm -f /tmp/*.7z

#=======================================================================
FROM debian:bullseye-slim

HEALTHCHECK NONE

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

RUN apt-get update && apt-get install -y `
        ca-certificates lib32z1 locales locales-all tmux &&`
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

# Set up Enviornment
RUN useradd --home /app --gid root --system UT99 &&`
    mkdir -p /app &&`
    chown UT99:root -R /app;

COPY --chown=UT99:root --from=ut99-builder /output /app

RUN chmod +x /app/checkfiles.sh /app/ucc /app/System/ucc-bin

COPY --chown=UT99:root /dist.linux/ /app/

RUN chmod +x /app/ll-tests/*.sh

USER UT99

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
