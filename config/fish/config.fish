if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Nightfox Color Palette
# Style: carbonfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/carbonfox/carbonfox.fish
set -l foreground f2f4f8
set -l selection 2a2a2a
set -l comment 6e6f70
set -l red ee5396
set -l orange 3ddbd9
set -l yellow 08bdba
set -l green 25be6a
set -l purple be95ff
set -l cyan 33b1ff
set -l pink ff7eb6

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

# Alias settings
if type eza >/dev/null 2>&1
    alias ls 'eza --icons'
    alias lt 'eza --icons --tree'
else if type lsd >/dev/null 2>&1
    alias ls lsd
    alias lt 'lsd --tree'
else if type exa >/dev/null 2>&1
    alias ls exa
end

if type bat >/dev/null 2>&1
    alias cat bat
else if type batcat >/dev/null 2>&1
    alias cat batcat
end

alias l 'ls -1a'
alias ll 'ls -lh'
alias la 'ls -lha'

alias c cd
alias th touch
alias md mkdir

alias g git
alias v nvim
alias vt 'nvim -c :terminal'
alias tm tmux
alias dp 'docker compose'

alias psh 'poetry shell'
alias prt 'poetry run tmux'

if type acpi >/dev/null 2>&1
    alias bi 'acpi -bi'
end

if type xsel >/dev/null 2>&1
    alias copy 'xsel --input --clipboard'
end

if type nvim >/dev/null 2>&1
    set -Ux EDITOR nvim
end

if [ -d /mnt/c ]
    alias code "/mnt/c/Users/SuperYuro/Appdata/Local/Programs/Microsoft\ VS\ Code/bin/code"
    alias explorer "/mnt/c/Windows/explorer.exe"
    alias clip "iconv -t UTF16 | /mnt/c/Windows/system32/clip.exe"
end

alias rl 'exec fish'

alias cv "cd (ghq root)"
alias ghl "cd (ghq root)/(ghq list | peco)"
# alias cv "cd ~/Development"
# alias ghl "cd ~/Development/(ls ~/Development | peco)"

alias lg lazygit

function goto_venv
    set -l venv_dirs ".venv" venv

    for dir in $venv_dirs
        if test -e "$dir/bin/activate.fish"
            # 仮想環境をアクティブにする
            source "$dir/bin/activate.fish"

            # 新しいシェルインスタンスを開始
            fish

            # シェルインスタンスが終了したら仮想環境を終了する
            deactivate
            return 0
        end
    end

    echo "No venv script files are found."
    return 1
end

alias pyvenv goto_venv

mise activate fish | source
