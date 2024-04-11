eval "$(sheldon source)"

# History
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000000
SAVEHIST=100000000

setopt inc_append_history
setopt share_history

function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# Alias
alias v="nvim"
alias g="git"
alias c="cd"
alias th="touch"
alias md="mkdir"

alias ls="eza --icons"
alias lt="eza --icons --tree"
alias la="eza --icons -lhA"
alias ll="eza --icons -lh"
alias l="eza --icons -1a"

alias cat="bat"

alias rl="exec zsh"

alias lg="lazygit"

# ghq
# peco の設定（リポジトリ間の移動を行う）
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

zle -N peco-src
alias ghl=peco-src

# Load nvm
[ -f "/usr/share/nvm/init-nvm.sh" ] && source /usr/share/nvm/init-nvm.sh
