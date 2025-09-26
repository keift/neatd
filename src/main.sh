#!/bin/bash

apt install -y coreutils util-linux
apt install -y --reinstall coreutils util-linux

dnf install -y coreutils util-linux
dnf reinstall -y coreutils util-linux

yum install -y coreutils util-linux
yum reinstall -y coreutils util-linux

zypper -n install coreutils util-linux
zypper -n install -f coreutils util-linux

pacman -S --noconfirm coreutils util-linux

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

sed -i "/^127\.0\.1\.1\s\+/s/\S\+$/$(hostname)/" /etc/hosts