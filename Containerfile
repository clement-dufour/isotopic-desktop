FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:e59d4b884f2fed599b553dd235473c908c82a36530d8ddf65965336e9bb56139
COPY image_files /

RUN --mount=type=tmpfs,target=/var << 'EOF'
set -e -o nounset -o pipefail
set -x

dnf config-manager disable \
    updates-archive \
    fedora-cisco-openh264 \


dnf --assumeyes remove \
    firefox \
    firefox-langpacks \
    gnome-software-rpm-ostree \
    gnome-tour \


dnf --assumeyes --setopt=install_weak_deps=False install \
    adw-gtk3-theme \
    ddcutil \
    fzf \
    gvfs-nfs \
    igt-gpu-tools \
    neovim \
    osbuild-selinux \
    tmux \
    usbguard \
    usbguard-notifier \


dnf clean all

systemctl preset-all

ostree container commit
EOF
