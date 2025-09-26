#!/bin/bash

apt install -y coreutils util-linux
apt install -y --reinstall coreutils util-linux

dnf install -y coreutils util-linux
dnf reinstall -y coreutils util-linux

yum install -y coreutils util-linux
yum reinstall -y coreutils util-linux

zypper install -y coreutils util-linux
zypper install -f coreutils util-linux

pacman -S --noconfirm coreutils util-linux

DEBIAN_FRONTEND=noninteractive
apt update -o Dpkg::Options::="--force-confold" -y
apt upgrade -o Dpkg::Options::="--force-confold" -y
apt autoremove -y

dnf check-update -y
dnf upgrade -y
dnf autoremove -y

yum check-update -y
yum update -y
yum autoremove -y

zypper refresh -y
zypper update -y
zypper remove -y $(zypper packages --unneeded | awk "NR>2 {print $5}")

pacman -Syu --noconfirm
pacman -Rns --noconfirm $(pacman -Qdtq)