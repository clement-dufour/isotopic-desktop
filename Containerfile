FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:43@sha256:e95dc4db674663333be8548a0b411dfd0789b3a7b43761dfb2f9a34562fcf0a8
COPY image_files /

RUN --mount=type=bind,from=build_scripts,src=/,dst=/build_scripts \
    /build_scripts/install.sh && \
    ostree container commit && \
    bootc container lint
