if status is-interactive
    # Commands to run in interactive sessions can go here

    # Alias settings
    if type eza >/dev/null 2>&1
        alias ls 'eza --icons=always'
        alias lt 'eza --icons=always --tree'
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

    abbr gpc 'gh pr create'
    abbr gpv 'gh pr view -w'
    abbr gpe 'gh pr edit'

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
        alias code "/mnt/c/Users/室雄太/Appdata/Local/Programs/Microsoft\ VS\ Code/bin/code"
        alias explorer "/mnt/c/Windows/explorer.exe"
        # alias clip "/mnt/c/Windows/system32/clip.exe"
        alias copy "/mnt/c/Users/室雄太/AppData/Local/Microsoft/WinGet/Links/win32yank.exe -i"
    end

    alias rl 'exec fish'

    alias lg lazygit

    alias gl ghq-tmux
    alias pyvenv goto-venv

    starship init fish | source

    direnv hook fish | source

    fish_config theme choose 'Catppuccin Latte'

    set -x FZF_DEFAULT_OPTS "--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 --color=selected-bg:#BCC0CC --color=border:#9CA0B0,label:#4C4F69"
end
