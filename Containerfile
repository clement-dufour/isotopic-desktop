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
        vagrant \
        vagrant-libvirt \
        virt-install \
        virt-manager \
        virt-viewer \
    && \
    systemctl enable rpm-ostreed-automatic.timer && \
    ostree container commit
