#!/bin/bash

apt install -y coreutils util-linux
apt install -y --reinstall coreutils util-linux

dnf install -y coreutils util-linux
dnf reinstall -y coreutils util-linux

yum install -y coreutils util-linux
yum reinstall -y coreutils util-linux

pacman -S --noconfirm coreutils util-linux

apt update -y
apt upgrade -y
apt autoremove -y

dnf check-update -y
dnf upgrade -y
dnf autoremove -y

yum check-update -y
yum update -y
yum autoremove -y

pacman -Syu --noconfirm
pacman -Rns --noconfirm $(pacman -Qdtq)