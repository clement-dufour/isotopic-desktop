FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:065a194d83cc86785e25f0e5857f8282019fce0d4d3a64239bb148b7b3dc19c1
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
    libimobiledevice \
    neovim \
    osbuild-selinux \
    tmux \
    usbguard \
    usbguard-notifier \


dnf clean all

systemctl preset-all

ostree container commit
EOF
