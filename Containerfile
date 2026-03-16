FROM scratch AS build_scripts
COPY build_scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:43@sha256:c54b787fe7ba032ba300a14ffb5c2ace1525c5314b7bef35d1c4fa6b38ce9532
COPY image_files /

RUN --mount=type=bind,from=build_scripts,src=/,dst=/build_scripts \
    /build_scripts/install.sh && \
    ostree container commit && \
    bootc container lint
