FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:43@sha256:a37e0af2921f348216680e4811a904da906fe72a3989e1a3ea0220479f29c63c
COPY image_files /

RUN --mount=type=bind,from=build_scripts,src=/,dst=/build_scripts \
    /build_scripts/install.sh && \
    ostree container commit && \
    bootc container lint
