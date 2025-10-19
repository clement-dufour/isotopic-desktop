#!/usr/bin/env bash

set -oue pipefail
set -x

dnf remove --assumeyes \
    firefox \
    firefox-langpacks \
    gnome-software-rpm-ostree \


dnf install --assumeyes \
    adw-gtk3-theme \
    ddcutil \
    fzf \
    gvfs-nfs \
    igt-gpu-tools \
    neovim \
    openssl \
    osbuild-selinux \
    playerctl \
    tmux \
    usbguard \
    usbguard-notifier \
    zstd \


dnf clean all

systemctl preset-all

# Rebuild initramfs to change plymouth theme
# https://gitlab.com/fedora/ostree/ci-test/-/tree/main
# https://github.com/coreos/layering-examples/blob/main/initramfs-module/Containerfile
# https://github.com/ublue-os/main/blob/main/initramfs.sh
KERNEL_VERSION=$(rpm -q kernel | cut -c 8-)
dracut --kver "${KERNEL_VERSION}" --force --add ostree --nostrip --verbose \
    --no-hostonly --zstd --reproducible \
    "/lib/modules/${KERNEL_VERSION}/initramfs.img"
chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"

# shellcheck shell=sh disable=SC2115
rm -r /var/*
