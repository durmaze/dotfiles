[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion


[[ -f ~/.alias ]] && source ~/.alias
[[ -f ~/.inputrc ]] && source ~/.inputrc

export GOPATH="$HOME/go"
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$PATH"
export EDITOR=/usr/bin/vim

set -o vi

export PATH="/usr/local/opt/curl/bin:$PATH"


# use fd for fzf, and colorize output
export FZF_DEFAULT_COMMAND='fd --type file --color=always --hidden --exclude .git'
export FZF_DEFAULT_OPTS="--ansi"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
