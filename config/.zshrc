autoload -Uz promptinit
promptinit
prompt redhat

autoload -Uz compinit
compinit

setopt correctall

setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt autocd
setopt extendedglob

bindkey -e
