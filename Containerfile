FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:d597198284ff73872278961dc5a2f1fdf7c2d0334ebfb296d943aca0e6a667e5
COPY image_files /

RUN --mount=type=bind,from=build_scripts,source=/,target=/build_scripts \
    --mount=type=tmpfs,target=/var \
    /build_scripts/install.sh && \
    ostree container commit
