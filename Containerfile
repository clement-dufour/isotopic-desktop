FROM scratch AS scripts
COPY scripts /

FROM quay.io/fedora-ostree-desktops/silverblue:41
COPY files /

RUN --mount=type=bind,from=scripts,src=/,dst=/scripts \
    /scripts/customize.sh && \
    ostree container commit
