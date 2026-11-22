#!/usr/bin/env bash
# usage: recreate.sh <name>   (なければ作成、あれば作り直し)
set -euo pipefail

name=${1:?usage: recreate.sh <name>}
dir=${INCUS_DEV_CONF:-$HOME/Documents/incus}
file=$dir/$name.yaml
[ -f "$file" ] || { echo "not found: $file" >&2; exit 1; }

# ファイルをもとにprofileを設定
incus profile show "$name" >/dev/null 2>&1 || incus profile create "$name"
incus profile edit "$name" < "$file"

if incus info "$name" >/dev/null 2>&1; then
  incus delete -f "$name"
fi

incus launch local:dev-base "$name" -p default -p "$name"
