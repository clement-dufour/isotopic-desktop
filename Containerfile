FROM quay.io/fedora-ostree-desktops/silverblue:40

COPY files /

RUN \
    mkdir -p /var/lib/alternatives && \
    rpm-ostree uninstall \
        firefox \
        firefox-langpacks \
    && \
    rpm-ostree install \
        ddcutil \
        fzf \
        gvfs-nfs \
        neovim \
        syncthing \
        ulauncher \
    && \
    systemctl enable rpm-ostreed-automatic.timer && \
    ostree container commit
