FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:43@sha256:ce723e23343f0805f72a97e83c5a45b08fcf72f7d9b7b2aa1cd20b2ad4dd9a99
COPY image_files /

RUN --mount=type=bind,from=build_scripts,src=/,dst=/build_scripts \
    /build_scripts/install.sh && \
    ostree container commit && \
    bootc container lint
