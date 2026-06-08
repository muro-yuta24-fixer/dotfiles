eval "$(mise activate zsh)"
eval "$(sheldon source)"
eval "$(direnv hook zsh)"

autoload -Uz compinit
compinit

setopt correctall

setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt autocd
setopt extendedglob

bindkey -e

#################
# === Alias === #
#################

alias ls="lsd"
alias l="lsd -1a"
alias ll="lsd -lh"
alias la="lsd -lha"

alias c=cd
alias th=touch
alias md=mkdir

alias g=git
alias v=nvim
# alias tm=launch-tmux
alias lg=lazygit

alias dp="docker compose"

alias gpc="gh pr create"
alias gpv="gh pr view -w"
alias gpe="gh pr edit"

alias da="direnv allow"

# alias gl=ghq-tmux
# alias pyvenv=goto-venv

alias rl="exec zsh"
