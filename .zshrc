# add snap to path
PATH=/snap/bin:$PATH
export PATH

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=512
SAVEHIST=16384
bindkey -e

# Completion settings
setopt globdots
autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Language seting(en_US.UTF-8)
export LANG='en_US.UTF-8'

# stop beep 
setopt no_beep
setopt nolistbeep

# GOPATH
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN


# setting for powerline-go
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

# colorize the completion candidate
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


# ls coloring (github.com/sharkdp/vivid is required)
export LS_COLORS="$(vivid generate snazzy)"
alias ls='ls -a --color=auto'
alias ll='ls -lah --color=auto'

#cd -> ls
chpwd() {
  ls
}

# typo
alias ccd='cd'

# shothand of systemctl
alias systat='systemctl status'
alias sysreload='sudo systemctl restart'

# sudo alias
alias sudos='sudo `fc -lrn -1`'

alias clip='xclip -selection clipboard'

# setting GPG sign tty
export GPG_TTY=$(tty)

# remove merged git branches at the same time
alias g-rmbranch='git branch --merged | grep -v "*" >/tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'
alias gc='git switch -c'
alias gp='git add -p'
alias gs='git status'

if type "fnm" > /dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi

# keychain
if type "keychain" > /dev/null 2>&1; then
    eval $(keychain --eval --quiet id_ed25519)
fi
