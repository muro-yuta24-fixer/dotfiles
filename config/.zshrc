autoload -Uz compinit
compinit

eval "$(starship init zsh)"

setopt correctall

setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt autocd
setopt extendedglob

bindkey -e

alias ls='ls --color=auto'
