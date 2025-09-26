#!/bin/bash

apt install -y coreutils util-linux logrotate
apt install -y --reinstall coreutils util-linux logrotate

dnf install -y coreutils util-linux logrotate
dnf reinstall -y coreutils util-linux logrotate

yum install -y coreutils util-linux logrotate
yum reinstall -y coreutils util-linux logrotate

zypper -n install coreutils util-linux logrotate
zypper -n install -f coreutils util-linux logrotate

pacman -S --noconfirm coreutils util-linux logrotate

DEBIAN_FRONTEND="noninteractive"
apt update -o Dpkg::Options::="--force-confold" -y
apt upgrade -o Dpkg::Options::="--force-confold" -y
apt autoremove -y

dnf check-update -y
dnf upgrade -y
dnf autoremove -y

yum check-update -y
yum update -y
yum autoremove -y

zypper -n refresh
zypper -n update
zypper -n remove $(zypper packages --unneeded | awk "/^i/ {print $5}" | xargs)

pacman -Syu --noconfirm
pacman -Rns --noconfirm $(pacman -Qdtq)

systemctl enable fstrim.timer
systemctl start fstrim.timer

systemctl enable logrotate.timer
systemctl start logrotate.timer

sed -i "/^127\.0\.1\.1\s\+/s/\S\+$/$(hostname)/" /etc/hosts

sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf