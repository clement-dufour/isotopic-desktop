FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:bdc29c71e5d6f37b70efca5de52ce927df127d17d132caa8c3a8aad2748536e9
COPY image_files /

RUN --mount=type=bind,from=build_scripts,source=/,target=/build_scripts \
    --mount=type=tmpfs,target=/var \
    /build_scripts/install.sh && \
    ostree container commit
