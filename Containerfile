FROM quay.io/fedora-ostree-desktops/silverblue:41
COPY image_files /

RUN <<EOF
set -oue pipefail
set -x

dnf5 remove --assumeyes \
firefox \
firefox-langpacks \
gnome-software-rpm-ostree \


dnf5 install --assumeyes \
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


dnf5 clean all

systemctl preset-all

KERNEL_VERSION=$(rpm -q kernel | cut -c 8-)
dracut --kver "${KERNEL_VERSION}" --force --add ostree --nostrip --verbose \
--no-hostonly --zstd --reproducible \
"/lib/modules/${KERNEL_VERSION}/initramfs.img"
chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"

ostree container commit
EOF
