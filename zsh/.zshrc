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

# Language
export LANG=en_US.UTF-8
# required for gcalcli (python)
export LC_ALL=en_US.UTF-8


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

# Install custom plugins (which requires manual installation)
ZSH_CUSTOM_PLUGINS=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
[[ -d $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting
[[ -d $ZSH_CUSTOM_PLUGINS/zsh-autosuggestions ]] || git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM_PLUGINS/zsh-autosuggestions
[[ -d $ZSH_CUSTOM_PLUGINS/zsh-completions ]] || git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM_PLUGINS/zsh-completions

# Plugins
plugins=(git vi-mode docker vagrant golang minikube kubectl zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

# Configure
export ZSH=/home/erkan/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/dotfiles/zsh/keybindings.sh

# Auto-suggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# inspired by vim keys
bindkey '^[l' autosuggest-accept 		# alt+l
bindkey '^[j' autosuggest-execute		# alt+j

# Auto-completions
# source kubectl package manager krew (https://krew.dev)
[[ -d ~/.krew ]] || source ~/dotfiles/zsh/.install_krew 
[[ -d ~/.krew ]] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# create .completions folder for custom zsh auto-completions
[[ -d ~/.completions ]] || { mkdir -p ~/.completions }
fpath=(~/.completions $fpath)

# source istioctl auto-completion 
[[ -f ~/.completions/_istioctl ]] || { istioctl collateral --zsh -o ~/.completions }
[[ -f ~/.completions/_istioctl ]] && source ~/.completions/_istioctl

# source kind auto-completion
[[ -f ~/.completions/_kind ]] || { kind completion zsh > ~/.completions/_kind }
[[ -f ~/.completions/_kind ]] && source ~/.completions/_kind

# reload auto-completions
autoload -U compinit && compinit

## ALIAS SECTION
[[ -f ~/.alias ]] && source ~/.alias


## PATH SECTION
# Golang
[[ $OS == 'Darwin' ]] && export GOROOT="/usr/local/opt/go/libexec"
[[ $OS == 'Darwin' ]] && export PATH="$PATH:$GOROOT/bin"
#export GOPATH="$HOME/workspace/go"
#export PATH="$HOME/.cargo/bin:$GOPATH/bin:$PATH"

# Curl
[[ $OS == 'Darwin' ]] && export PATH="/usr/local/opt/curl/bin:$PATH"


## FZF SECTION - MOVE THESE TO FZF.ZSH AND ADD LINUX SUPPORT
# Key bindings and shell completion
if [[ $OS == 'Linux' ]] then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
elif [[ $OS == 'Darwin' && -f ~/.fzf.zsh ]] then
	source ~/.fzf.zsh
fi

# Use fd as the default command
FD_OPTS="--follow --hidden --exclude .git --exclude node_modules" 

# Configure behavior of the interactive finder. Set some options, preview handlers, and key bindings
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | xclip -selection clipboard)'"

# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
# export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTS"


## TERMINAL SECTION
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
