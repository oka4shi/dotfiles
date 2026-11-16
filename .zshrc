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

# Inhibit suspend when connected via SSH
if [[ -n $SSH_CONNECTION && -z $TMUX ]]; then
    gnome-session-inhibit --reason="Inhibit suspend during SSH connection aliving" --inhibit="suspend" sleep infinity &!
fi


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

# mise
if type "mise" > /dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# pyenv
if type "pyenv" > /dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)"
fi


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

# tmux attach
alias ta='tmux list-sessions -F '#{session_name}' | xargs -I {} tmux detach-client -s {}; tmux attach'

if type "zigup" > /dev/null 2>&1; then
    alias zigup="zigup --path-link $HOME/.local/bin/zig"
fi

# Incus
source ~/.zsh/ic.zsh

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

# ls coloring
export LS_COLORS="$(<~/.zsh/ls_colors_snazzy)"

# colorize the completion candidate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#cd -> ls
chpwd() {
  ls
}
