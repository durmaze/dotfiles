# install bash completion for fzf 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# use extended search (i.e. regex)
export FZF_DEFAULT_OPTS="--extended"

# change default find command for fzf to 'fd', which respects .gitignore
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
