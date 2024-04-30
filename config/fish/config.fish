if status is-interactive
    # Commands to run in interactive sessions can go here
end

# (Github Light) Colors for Fish shell
set -l comment 57606a

# Shell highlight groups
# (https://fishshell.com/docs/current/interactive.html#variables-color)

set -g fish_color_normal brwhite # Default text
set -g fish_color_command brwhite # 'cd', 'ls', 'echo'
# set -g fish_color_keyword red  # 'if'   NOTE: default = $fish_color_command
set -g fish_color_quote green # "foo" in 'echo "foo"'
# set -g fish_color_redirection magenta  # '>/dev/null'   NOTE: default = magenta
# set -g fish_color_end blue  # ; in 'cmd1; cmd2'   NOTE: default = blue
# set -g fish_color_error red  # incomplete / non-existent commands   NOTE: default = red
set -g fish_color_param blue # xvf in 'tar xvf', --all in 'ls --all'
set -g fish_color_comment $comment # '# a comment' # Question: Where does default come from if not set?
# set -g fish_color_selection --background=$selection # Run 'fish_vi_key_bindings', type some text, <Esc> then 'v' to select text
set -g fish_color_operator red # * in 'ls ./*'
# set -g fish_color_escape cyan  # ▆ in 'echo ▆' NOTE: default = cyan
set -g fish_color_autosuggestion $comment # Appended virtual text, e.g. 'cd  ' displaying 'cd ~/some/path'
# set -g fish_color_search_match --background=red   # TODO: How to trigger?

set -g fish_pager_color_completion $fish_color_param # List of suggested items for 'ls <Tab>'
set -g fish_pager_color_description green # (command) in list of commands for 'c<Tab>'
set -g fish_pager_color_prefix red --underline # Leading 'c' in list of completions for 'c<Tab>'
set -g fish_pager_color_progress brwhite # '…and nn more rows' for 'c<Tab>'
set -g fish_pager_color_selected_background --background=$selection # Cursor when <Tab>ing through 'ls <Tab>'

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
    alias clip "/mnt/c/Windows/system32/clip.exe"
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
