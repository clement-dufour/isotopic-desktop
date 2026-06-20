FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:2c170c8517deaa8e447d9023544778f66d8d390fda5ccd770d41d5706efdbf7a
COPY image_files /

RUN --mount=type=bind,from=build_scripts,source=/,target=/build_scripts \
    --mount=type=tmpfs,target=/var \
    /build_scripts/install.sh && \
    ostree container commit
