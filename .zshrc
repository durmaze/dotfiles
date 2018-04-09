[[ -f ~/.alias ]] && source ~/.alias
[[ -f ~/.inputrc ]] && source ~/.inputrc

export GOPATH="$HOME/go"
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$PATH"
export EDITOR=/usr/bin/vim

set -o vi

export PATH="/usr/local/opt/curl/bin:$PATH"

# configure FZF
# install zsh completion for fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# use fd for fzf, and colorize output
export FZF_DEFAULT_COMMAND='fd --type file --color=always --hidden --exclude .git'
export FZF_DEFAULT_OPTS="--extended"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"


# tweak iterm2 title bar colors for One Dark theme
echo -e "\033]6;1;bg;red;brightness;40\a"
echo -e "\033]6;1;bg;green;brightness;44\a"
echo -e "\033]6;1;bg;blue;brightness;52\a"
