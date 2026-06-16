FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:2318afd7a143c52713a561cccfc5cb9b76fc3c0d0b54127798c161ed7cf74108
COPY image_files /

RUN --mount=type=bind,from=build_scripts,source=/,target=/build_scripts \
    --mount=type=tmpfs,target=/var \
    /build_scripts/install.sh && \
    ostree container commit
