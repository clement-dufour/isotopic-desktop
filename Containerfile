FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:cff5f9468fda0771bd06d8a156766c3a2079c6a56208bfedc107c4fc3421623f
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
