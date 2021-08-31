# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=512
SAVEHIST=512
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Language seting(en_US.UTF-8)
export LANG='en_US.UTF-8'

# stop beep 
setopt no_beep
setopt nolistbeep

# GOPATH
export GOPATH=$HOME/


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


# ls coloring (github.com/shrkdp/vivid is required)
export LS_COLORS="$(vivid generate snazzy)"
alias ls='ls -a --color=auto'
alias ll='ls -lah --color=auto'

#cd -> ls
chpwd() {
  ls
}

# shothand of systemctl
alias systat='systemctl status'
alias sysreload='sudo systemctl restart'

# sudo alias
alias sudos='sudo `fc -lrn -1`'

# setting GPG sign tty
export GPG_TTY=$(tty)

