#!/usr/bin/env bash
set -euxo pipefail
cd "$HOME"
export PATH="$HOME/.local/bin:$PATH"

# powerline-go
install_powerline_go() {
  local arch dir
  case "$(uname -m)" in
    x86_64|amd64)  arch=amd64 ;;
    aarch64|arm64) arch=arm64 ;;
    armv6l|armv7l) arch=arm ;;
    i386|i686)     arch=386 ;;
    *) echo "powerline-go: 未対応のアーキテクチャ: $(uname -m)" >&2; return 1 ;;
  esac

  dir="${INSTALL_DIR:-$HOME/.local/bin}"
  mkdir -p "$dir" || return 1

  curl -fsSL -o "$dir/powerline-go.tmp" \
    "https://github.com/justjanne/powerline-go/releases/latest/download/powerline-go-linux-${arch}" \
    && chmod +x "$dir/powerline-go.tmp" \
    && mv "$dir/powerline-go.tmp" "$dir/powerline-go" \
    || { rm -f "$dir/powerline-go.tmp"; echo "powerline-go: インストールに失敗しました" >&2; return 1; }
}
install_powerline_go || echo "powerline-go をスキップして続行します" >&2

# Mise
curl -fsSL https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc

# Install tools with Mise
mise use -g neovim@latest node@latest tree-sitter@latest
export PATH="$HOME/.local/share/mise/shims:$PATH"

# dotfiles
git clone https://github.com/oka4shi/dotfiles ~/.dotfiles
[ -x ~/.dotfiles/setup.sh ] && ~/.dotfiles/setup.sh -y || true

# NeoVim
ln -s ~/.dotfiles/nvim ~/.config/nvim
nvim --headless -c 'lua vim.pack.update(nil, {force = true})' -c 'qa'
