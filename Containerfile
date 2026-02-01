FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:43@sha256:704b6cbe466f80c23cd73fb5282445ebef43ab0868ebb033fcd1fe2fd542688c
COPY image_files /

RUN --mount=type=bind,from=build_scripts,src=/,dst=/build_scripts \
    /build_scripts/install.sh && \
    ostree container commit && \
    bootc container lint
