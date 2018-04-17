[[ -f ~/.alias ]] && source ~/.alias

export LANG=en_US.UTF-8

export GOPATH="$HOME/go"
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$PATH"

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


# run tmux if exists
[ -z $TMUX ] && exec tmux

# Vars
	HISTFILE=~/.zsh_history
	HISTSIZE=1000000
	SAVEHIST=1000000
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history

# For vim mappings:(ctrl+s, ctrl+q) 
	stty -ixon

# source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
# source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
# source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/keybindings.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

source ~/dotfiles/zsh/prompt.sh

# oh-my-zsh config
export ZSH=/Users/erkand/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# oh-my-zsh plugins
plugins=(git vi-mode docker vagrant zsh-completions zsh-autosuggestions zsh-syntax-highlighting)


# ===================
#    THIRD PARTY
# ===================
# brew install jump
# https://github.com/gsamokovarov/jump
eval "$(jump shell)"
