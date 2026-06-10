FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:31ad2a85e4b9bf382410388b2a9f7db3b4ee74dd6b055df3bf767abe1b178095
COPY image_files /

RUN --mount=type=bind,from=build_scripts,source=/,target=/build_scripts \
    --mount=type=tmpfs,target=/var \
    /build_scripts/install.sh && \
    ostree container commit
