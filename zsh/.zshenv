export EDITOR="vim"
export TERMINAL="termite"
export BROWSER="google-chrome-stable"
export READER="zathura"
export FILE="vifm"

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Golang
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin" 		# not required
export PATH="$PATH:$GOBIN"

# Man
export MANPAGER="sh -c 'col -bx | bat -l man -p'" 		# set MANPAGER to 'bat'
# export MANROFFOPT="-c" 								# set if you experience formatting problems
