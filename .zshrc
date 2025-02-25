# === path ===
# add snap to path
PATH=/snap/bin:$PATH
export PATH

# GOPATH
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN


# === system ===
# Language seting(C.UTF-8)
export LANG='C.UTF-8'

# setting GPG sign tty
export GPG_TTY=$(tty)


# === zsh ===
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=512
SAVEHIST=16384
bindkey -e

# Completion settings
setopt globdots
autoload -Uz compinit
compinit

# stop beep 
setopt no_beep
setopt nolistbeep

# ls coloring (github.com/sharkdp/vivid is required)
export LS_COLORS="$(vivid generate snazzy)"

# colorize the completion candidate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#cd -> ls
chpwd() {
  ls
}


# === aliases ===
# typo
alias ccd='cd'

# aliases for ls
alias ls='ls -a --color=auto'
alias ll='ls -lah --color=auto'

# shothand of systemctl
alias dstatus='systemctl status'
alias drestart='sudo systemctl restart'
alias denable='sudo systemctl enable --now'

# execute the former command with sudo
alias sudos='sudo `fc -lrn -1`'

# copy standard input to clipboard
alias clip='xclip -selection clipboard'

# remove merged git branches at the same time
alias g-rmbranch='git branch --merged | grep -v "*" >/tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'

# shorthands of git commands
alias gc='git switch -c'
alias gp='git add -p'
alias gs='git status'


# === initialization of tools ===
# powerline-go
function powerline_precmd() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs ${${(%):%j}:-0})"
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    install_powerline_precmd
fi

# fnm
if type "fnm" > /dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi

# keychain
if type "keychain" > /dev/null 2>&1; then
    eval $(keychain --eval --quiet id_ed25519)
fi
