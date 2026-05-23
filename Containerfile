FROM quay.io/fedora-ostree-desktops/silverblue:44@sha256:bdc29c71e5d6f37b70efca5de52ce927df127d17d132caa8c3a8aad2748536e9
COPY image_files /

RUN <<EOF
set -oue pipefail
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
