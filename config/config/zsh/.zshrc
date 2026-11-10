# ============================================================================
# Options
# ============================================================================

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p "${HISTFILE:h}"
HISTSIZE=100000
SAVEHIST=100000

setopt share_history        # 複数のセッション間で履歴を共有する
setopt hist_ignore_all_dups # 重複したコマンドは古い方を削除する
setopt hist_ignore_space    # 先頭がスペースのコマンドは履歴に残さない
setopt hist_reduce_blanks   # 余分な空白を除去して記録する
setopt auto_cd              # ディレクトリ名だけで移動する
setopt auto_pushd pushd_ignore_dups
setopt interactive_comments # 対話シェルでも # 以降をコメントとして扱う
setopt no_beep

bindkey -e

# 入力済みの文字列で前方一致の履歴検索をする (fishの上下キーの挙動)
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# ============================================================================
# Plugins / Completion
# ============================================================================

# sheldonはmiseで導入するが、mise activate は compdef が未定義だと独自に
# compinit を実行してしまうため、activate せずに実行ファイルの場所を調べる
if (( $+commands[sheldon] )); then
    eval "$(sheldon source)"
elif (( $+commands[mise] )) && sheldon_bin=$(mise which sheldon 2>/dev/null); then
    eval "$("$sheldon_bin" source)"
fi
unset sheldon_bin

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字を区別しない
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 自作の補完ファイル (compinitより前にfpathへ追加する必要がある)
fpath=("$ZDOTDIR/completions" $fpath)

autoload -Uz compinit
zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
[[ -d ${zcompdump:h} ]] || mkdir -p "${zcompdump:h}"
compinit -d "$zcompdump"
unset zcompdump

# 自作関数 (functions/ 以下のファイル名がそのまま関数名になる)
fpath=("$ZDOTDIR/functions" $fpath)
autoload -Uz "$ZDOTDIR"/functions/*(N:t)

# ============================================================================
# Tools
# ============================================================================

# compinit より後に有効化する (上記の理由)
(( $+commands[mise] )) && eval "$(mise activate zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

export FZF_DEFAULT_OPTS="--color=bg+:#002c38,bg:#001419,spinner:#c94c16,hl:#c94c16 --color=fg:#9eabac,header:#c94c16,info:#637981,pointer:#c94c16 --color=marker:#c94c16,fg+:#adb7b7,prompt:#c94c16,hl+:#c94c16 --color=selected-bg:#063540 --color=border:#063540,label:#9eabac,gutter:#001419,scrollbar:#063540,separator:#063540"

# ============================================================================
# Aliases
# ============================================================================

if (( $+commands[eza] )); then
    alias ls='eza --icons=always'
    alias lt='eza --icons=always --tree'
elif (( $+commands[lsd] )); then
    alias ls=lsd
    alias lt='lsd --tree'
elif (( $+commands[exa] )); then
    alias ls=exa
fi

if (( $+commands[bat] )); then
    alias cat=bat
elif (( $+commands[batcat] )); then
    alias cat=batcat
fi

alias l='ls -1a'
alias ll='ls -lh'
alias la='ls -lha'

alias c=cd
alias th=touch
alias md=mkdir

alias g=git
alias v=nvim
alias vt='nvim -c :terminal'
alias tm=launch-tmux
alias dp='docker compose'

if (( $+commands[acpi] )); then
    alias bi='acpi -bi'
fi

if (( $+commands[xsel] )); then
    alias copy='xsel --input --clipboard'
fi

if [[ -d /mnt/c ]]; then
    alias code='"/mnt/c/Users/室雄太/Appdata/Local/Programs/Microsoft VS Code/bin/code"'
    alias explorer=/mnt/c/Windows/explorer.exe
    alias copy='/mnt/c/Users/室雄太/AppData/Local/Microsoft/WinGet/Links/win32yank.exe -i'
fi

alias rl='exec zsh'

alias lg=lazygit

alias gl=ghq-tmux
alias pyvenv=goto-venv

# ============================================================================
# Abbreviations (zsh-abbr)
# ============================================================================

if (( $+functions[abbr] )); then
    # -S: セッション限定 (ユーザーの abbreviations ファイルに書き込まない)
    (( $+commands[podman] )) && abbr -S -q docker=podman
    abbr -S -q gpc='gh pr create'
    abbr -S -q gpv='gh pr view -w'
    abbr -S -q gpe='gh pr edit'
    abbr -S -q da='direnv allow'
    abbr -S -q hwcb='herdr worktree create --branch'
fi
