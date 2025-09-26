#!/bin/bash

set -ouex pipefail

dnf5 versionlock clear
mkdir -p /etc/flatpak/remotes.d/
curl --retry 3 -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo
mv -f /usr/lib/systemd/system/flatpak-add-flathub-repos.service /usr/lib/systemd/system/flatpak-add-fedora-repos.service
curl -sSLo /usr/lib/systemd/system-generators/coreos-sulogin-force-generator https://raw.githubusercontent.com/coreos/fedora-coreos-config/refs/heads/stable/overlay.d/05core/usr/lib/systemd/system-generators/coreos-sulogin-force-generator
chmod +x /usr/lib/systemd/system-generators/coreos-sulogin-force-generator
rm -f /usr/bin/chsh
rm -f /usr/bin/lchsh
mv '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md'
cp /usr/share/ublue-os/update-services/etc/rpm-ostreed.conf /etc/rpm-ostreed.conf
ln -s '/usr/share/fonts/google-noto-sans-cjk-fonts' '/usr/share/fonts/noto-cjk'
dnf5 clean all
rm -rf /tmp/* || true
rm -rf /usr/etc
rm -rf /boot && mkdir /boot
find /var/* -maxdepth 0 -type d \! -name cache \! -name log -exec rm -rf {} \;
find /var/cache/* -maxdepth 0 -type d \! -name libdnf5 -exec rm -rf {} \;
mkdir -p /var/tmp
chmod -R 1777 /var/tmp
