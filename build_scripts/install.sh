#!/usr/bin/env bash

set -oue pipefail
set -x

/usr/bin/dnf5 remove --assumeyes \
    firefox \
    firefox-langpacks \
    gnome-software-rpm-ostree \


/usr/bin/dnf5 install --assumeyes \
    adw-gtk3-theme \
    ddcutil \
    fzf \
    gvfs-nfs \
    neovim \
    openssl \
    osbuild-selinux \
    syncthing \
    usbguard \
    usbguard-notifier \
    zstd \


/usr/bin/dnf5 clean all

/usr/bin/systemctl preset-all

# Rebuild initramfs to change plymouth theme
# https://gitlab.com/fedora/ostree/ci-test/-/tree/main
# https://github.com/coreos/layering-examples/blob/main/initramfs-module/Containerfile
# https://github.com/ublue-os/main/blob/main/initramfs.sh
KERNEL_VERSION=$(rpm -q kernel | cut -c 8-)
/usr/bin/dracut --kver "${KERNEL_VERSION}" --force --add ostree --nostrip \
    --verbose --no-hostonly --zstd --reproducible \
    "/lib/modules/${KERNEL_VERSION}/initramfs.img"
/usr/bin/chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"
