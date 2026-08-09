FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:c2589b7b8cacd8ce0b1dcae2ee52a96d223fe885fb0f1ba70cd706b668a6c43b
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
