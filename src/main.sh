#!/bin/bash

apt install -y systemd coreutils util-linux logrotate
apt install -y --reinstall systemd coreutils util-linux logrotate

dnf install -y systemd coreutils util-linux logrotate
dnf reinstall -y systemd coreutils util-linux logrotate

yum install -y systemd coreutils util-linux logrotate
yum reinstall -y systemd coreutils util-linux logrotate

zypper -n install systemd coreutils util-linux logrotate
zypper -n install -f systemd coreutils util-linux logrotate

pacman -S --noconfirm --overwrite "*" systemd coreutils util-linux logrotate

export DEBIAN_FRONTEND="noninteractive"

apt update -o Dpkg::Options::="--force-confold" -y
apt upgrade -o Dpkg::Options::="--force-confold" -y
apt autoremove -y --purge

dnf upgrade -y
dnf autoremove -y

yum upgrade -y
yum autoremove -y

zypper -n refresh
zypper -n update
zypper -n remove $(zypper packages --unneeded | awk "/^i/ {print $5}")

pacman -Syu --noconfirm
pacman -Rns --noconfirm $(pacman -Qdtq)

systemctl enable fstrim.timer
systemctl start fstrim.timer

systemctl enable logrotate.timer
systemctl start logrotate.timer

systemctl enable systemd-tmpfiles-clean.timer
systemctl start systemd-tmpfiles-clean.timer

ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

curl -fsSL https://raw.githubusercontent.com/keift/neatd/refs/heads/main/src/uninstall.sh | sh

echo "Neatd worked successfully."