# PATHの重複を除外する
typeset -U path PATH
path=("$HOME/.local/bin" $path)

if (( $+commands[nvim] )); then
    export EDITOR=nvim
fi

# Ubuntu/Debianの /etc/zsh/zshrc で compinit を実行させない (.zshrc で実行する)
skip_global_compinit=1
