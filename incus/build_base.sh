#!/usr/bin/env bash
# dev-base イメージをビルドして公開する
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

DEV_USER=${DEV_USER:-okashi}

B=builder
bx() { incus exec "$B" -- "$@"; }

incus delete -f "$B" 2>/dev/null || true
trap 'incus delete -f "$B" >/dev/null 2>&1 || true' EXIT

# 今の dev-base を控える
old=$(incus image info local:dev-base 2>/dev/null | awk '/^Fingerprint:/ {print $2}' || true)

# builder を起動
incus launch images:ubuntu/26.04 "$B" -c security.privileged=false

# 起動とネットワークを待つ
until bx true 2>/dev/null; do sleep 1; done
until bx getent hosts archive.ubuntu.com >/dev/null 2>&1; do sleep 1; done

# セットアップスクリプトを実行
bx env DEV_USER="$DEV_USER" bash -s < builder/system-setup.sh
bx runuser -l "$DEV_USER" -c 'bash -s' < builder/user-setup.sh

# machine-idをリセットする
bx sh -eu <<'EOF'
: > /etc/machine-id
rm -f /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id
rm -f /var/lib/systemd/random-seed
EOF

# ユーザー作成と mise 導入を確認
user=$(bx getent passwd 1000 | cut -d: -f1)
[ -n "$user" ] && [ "$user" != ubuntu ]
bx runuser -l "$user" -c '~/.local/bin/mise exec -- nvim --version >/dev/null'

# 公開してエイリアスを付け替える
incus stop "$B"
incus publish "$B" --alias dev-base --reuse

# builder と古いイメージを削除
incus delete -f "$B"
new=$(incus image info local:dev-base | awk '/^Fingerprint:/ {print $2}')
echo "done: dev-base -> $new"
