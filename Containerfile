FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:92230e473c7ace23ffa8c7293dc5308d0b978190088ff5bb74c70f9412df1b19
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
