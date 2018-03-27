[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion


[[ -f ~/.alias ]] && source ~/.alias
[[ -f ~/.inputrc ]] && source ~/.inputrc

export GOPATH="$HOME/go"
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$PATH"
export EDITOR=/usr/bin/vim

set -o vi

export PATH="/usr/local/opt/curl/bin:$PATH"
