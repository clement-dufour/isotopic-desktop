#!/usr/bin/bash

set -ouex pipefail

rpm-ostree cliwrap install-to-root /

mkdir -p /var/lib/alternatives

rpm-ostree uninstall \
    firefox \
    firefox-langpacks \
    gnome-software-rpm-ostree \

rpm-ostree install \
    ddcutil \
    fzf \
    gvfs-nfs \
    neovim \
    syncthing \
    usbguard \
    usbguard-notifier \
    virt-install \
    virt-manager \
    virt-viewer \
    zstd \

systemctl preset-all

# https://gitlab.com/fedora/ostree/ci-test/-/tree/main
# https://github.com/coreos/layering-examples/blob/main/initramfs-module/Containerfile
# https://github.com/ublue-os/main/blob/main/initramfs.sh
KERNEL_VERSION=$(rpm -q kernel | cut -c 8-)
/usr/libexec/rpm-ostree/wrapped/dracut --kver "${KERNEL_VERSION}" --force \
    --add 'ostree' --nostrip --verbose --no-hostonly --zstd --reproducible \
    "/lib/modules/${KERNEL_VERSION}/initramfs.img"
