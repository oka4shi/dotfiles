#!/usr/bin/env bash
#
# Create symlinks in $HOME to files located next to this script (with confirmation).
#
# Usage:
#   ./setup.sh                  # use the FILES list below
#   ./setup.sh .zshrc .vimrc    # specify files as arguments
#   ./setup.sh -y .zshrc        # skip confirmation
#
set -euo pipefail

# Files to link (relative to this script). Arguments override this list.
FILES=(
  ".tmux.conf"
  ".zsh"
  ".zshrc"
  ".vimrc"
  ".gitconfig"
)

SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

ASSUME_YES=false
if [[ "${1:-}" == "-y" ]]; then
  ASSUME_YES=true
  shift
fi

[[ $# -gt 0 ]] && FILES=("$@")

# Build the list of valid targets
VALID=()
echo "Links to be created:"
for f in "${FILES[@]}"; do
  dest="$HOME/$f"
  if [[ "$f" == "$SCRIPT_NAME" ]]; then
    echo "  [skip] $f (this script)"
  elif [[ ! -e "$SCRIPT_DIR/$f" ]]; then
    echo "  [skip] $f (source does not exist)"
  elif [[ -L "$dest" ]]; then
    echo "  $dest -> $SCRIPT_DIR/$f  [will overwrite existing symlink]"
    VALID+=("$f")
  elif [[ -d "$dest" ]]; then
    echo "  [skip] $f (a directory exists at $dest)"
  elif [[ -e "$dest" ]]; then
    echo "  $dest -> $SCRIPT_DIR/$f  [WARNING: will overwrite existing regular file]"
    VALID+=("$f")
  else
    echo "  $dest -> $SCRIPT_DIR/$f"
    VALID+=("$f")
  fi
done

if [[ ${#VALID[@]} -eq 0 ]]; then
  echo "Nothing to link." >&2
  exit 1
fi

# Confirm
if [[ "$ASSUME_YES" == false ]]; then
  read -r -p "Proceed? [y/N]: " answer
  [[ "$answer" =~ ^[yY]([eE][sS])?$ ]] || { echo "Cancelled."; exit 0; }
fi

# Create links (-f overwrites existing files/links, -n avoids following existing dir symlinks)
for f in "${VALID[@]}"; do
  dest="$HOME/$f"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$SCRIPT_DIR/$f" "$dest"
  echo "Linked: $dest"
done
