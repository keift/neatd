#!/bin/bash

apt install -y systemd coreutils util-linux logrotate
apt install -y --reinstall systemd coreutils util-linux logrotate

dnf install -y systemd coreutils util-linux logrotate
dnf reinstall -y systemd coreutils util-linux logrotate

yum install -y systemd coreutils util-linux logrotate
yum reinstall -y systemd coreutils util-linux logrotate

zypper -n install systemd coreutils util-linux logrotate
zypper -n install -f systemd coreutils util-linux logrotate

pacman -S --noconfirm systemd coreutils util-linux logrotate

<<<<<<< HEAD
DEBIAN_FRONTEND='noninteractive'
apt update -o Dpkg::Options::='--force-confold' -y
apt upgrade -o Dpkg::Options::='--force-confold' -y
=======
export DEBIAN_FRONTEND="noninteractive"

apt update -o Dpkg::Options::="--force-confold" -y
apt upgrade -o Dpkg::Options::="--force-confold" -y
>>>>>>> 85143006ee71ce1d1a5698e194be01c5a9154f26
apt autoremove -y

dnf check-update -y
dnf upgrade -y
dnf autoremove -y

yum check-update -y
yum update -y
yum autoremove -y

zypper -n refresh
zypper -n update
zypper -n remove $(zypper packages --unneeded | awk '/^i/ {print $5}' | xargs)

pacman -Syu --noconfirm
pacman -Rns --noconfirm $(pacman -Qdtq)

systemctl enable fstrim.timer
systemctl start fstrim.timer

systemctl enable logrotate.timer
systemctl start logrotate.timer

systemctl enable systemd-tmpfiles-clean.timer
systemctl start systemd-tmpfiles-clean.timer

sed -i '/^127\.0\.1\.1\s\+/s/\S\+$/$(hostname)/' /etc/hosts

ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

echo "Neatd worked successfully."