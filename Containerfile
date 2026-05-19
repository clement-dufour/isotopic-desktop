FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:8020ec50674087f0f99c3001d69323171d4ff2b4692f2f63e014f3611be617f3
COPY image_files /

RUN --mount=type=bind,from=build_scripts,src=/,dst=/build_scripts \
    /build_scripts/install.sh && \
    ostree container commit && \
    bootc container lint
