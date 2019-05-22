OS=$(uname)

## OPTIONS SECTION
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

# Tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':completion:*' accept-exact '*(N)'			# Speed up completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Editor 
export EDITOR=/usr/sbin/vim
export VISUAL=/usr/sbin/vim

# Navigation
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
	
# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt inc_append_history # To save every command before it is executed 
setopt share_history # setopt inc_append_history

## MAN PAGES
# Color man pages. Ref: https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


## OH-MY-ZSH SECTION 
# Install
[[ -d ~/.oh-my-zsh ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Plugins
plugins=(git vi-mode docker vagrant golang)

# Configure
export ZSH=/home/erkan/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
# zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting may be added
source ~/dotfiles/zsh/keybindings.sh

## ALIAS SECTION
[[ -f ~/.alias ]] && source ~/.alias

export LANG=en_US.UTF-8
# required for gcalcli (python)
export LC_ALL=en_US.UTF-8

[[ $OS == 'Darwin' ]] && export GOROOT="/usr/local/opt/go/libexec"
[[ $OS == 'Darwin' ]] && export PATH="$PATH:$GOROOT/bin"
#export GOPATH="$HOME/workspace/go"
#export PATH="$HOME/.cargo/bin:$GOPATH/bin:$PATH"

[[ $OS == 'Darwin' ]] && export PATH="/usr/local/opt/curl/bin:$PATH"

## FZF SECTION - MOVE THESE TO FZF.ZSH AND ADD LINUX SUPPORT
# Configure
[[ $OS == 'Darwin' && -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# use fd for fzf, and colorize output
export FZF_DEFAULT_COMMAND='fd --type file --color=always --hidden --exclude .git'
export FZF_DEFAULT_OPTS="--extended"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# tweak iterm2 title bar colors for One Dark theme
[[ $OS == 'Darwin' ]] && echo -e "\033]6;1;bg;red;brightness;40\a"
[[ $OS == 'Darwin' ]] && echo -e "\033]6;1;bg;green;brightness;44\a"
[[ $OS == 'Darwin' ]] && echo -e "\033]6;1;bg;blue;brightness;52\a"


## TMUX SECTION
# Run tmux if exists
[[ -z $TMUX ]] && exec tmux

# For vim mappings:(ctrl+s, ctrl+q). free up these keys.
stty -ixon

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


# ===================
#    THIRD PARTY
# ===================
# brew install jump
# https://github.com/gsamokovarov/jump
[[ $OS == 'Darwin' ]] && eval "$(jump shell)"

neofetch
