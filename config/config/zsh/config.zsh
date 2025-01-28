bindkey -e

setopt autocd
setopt extendedglob

export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"

setopt hist_ignore_all_dups
setopt hist_ignore_space

eval "$(sheldon source)"
