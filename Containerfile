FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:6869f9aab05bcca6918b5e28a552e74802694d7d78d5005142b166aba8db7769
COPY image_files /

RUN --mount=type=tmpfs,target=/var << 'EOF'
set -euo pipefail
set -x

dnf config-manager disable \
    updates-archive \
    fedora-cisco-openh264 \


dnf remove --assumeyes \
    firefox \
    firefox-langpacks \
    gnome-software-rpm-ostree \
    gnome-tour \


dnf install --assumeyes \
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

KERNEL_VERSION=$(rpm --query --queryformat "%{VERSION}-%{RELEASE}.%{ARCH}\n" kernel)
dracut --kver "${KERNEL_VERSION}" --force --add ostree --nostrip --verbose \
    --no-hostonly --zstd --reproducible \
    "/lib/modules/${KERNEL_VERSION}/initramfs.img"
chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"

ostree container commit
EOF
