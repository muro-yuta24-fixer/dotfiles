# zshの設定ファイルを ~/.config/zsh にまとめる
# ZDOTDIRが継承された子シェルでは $ZDOTDIR/.zshenv が直接読まれるため、
# このファイルではZDOTDIRの設定だけを行い、本体は $ZDOTDIR/.zshenv に置く
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
source "$ZDOTDIR/.zshenv"
