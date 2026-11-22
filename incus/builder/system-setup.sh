#!/usr/bin/env bash
set -euxo pipefail
: "${DEV_USER:?DEV_USER is required}"
export DEBIAN_FRONTEND=noninteractive

# Switch mirror
MIRROR="${MIRROR:-https://ftp.tsukuba.wide.ad.jp/ubuntu}"

if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then
  sed -i -E "s|https?://[^/ ]*archive\.ubuntu\.com/ubuntu/?|${MIRROR%/}/|g" /etc/apt/sources.list.d/ubuntu.sources
else
  sed -i -E "s|https?://[^/ ]*archive\.ubuntu\.com/ubuntu/?|${MIRROR%/}/|g" /etc/apt/sources.list
fi

apt-get update
apt-get -y upgrade
apt-get install -y sudo zsh git curl wget ca-certificates \
  build-essential unzip ripgrep fd-find

# Remove default user and create new one
if id ubuntu >/dev/null 2>&1; then userdel -rf ubuntu; fi
useradd -m -u 1000 -G sudo -s /usr/bin/zsh "$DEV_USER"
passwd -l "$DEV_USER"
echo "$DEV_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-dev
chmod 440 /etc/sudoers.d/90-dev

# Remove SSH
apt-get purge -y openssh-server openssh-sftp-server
rm -f /etc/ssh/ssh_host_*
apt-get autoremove -y
apt-get clean
