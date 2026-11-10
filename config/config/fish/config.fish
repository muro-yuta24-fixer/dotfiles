if status is-interactive
    # Commands to run in interactive sessions can go here
    mise activate fish | source
    starship init fish | source
    direnv hook fish | source

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

    if type podman >/dev/null 2>&1
        abbr docker podman
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
    alias tm launch-tmux
    alias dp 'docker compose'

    abbr gpc 'gh pr create'
    abbr gpv 'gh pr view -w'
    abbr gpe 'gh pr edit'

    abbr da "direnv allow"

    abbr hwcb "herdr worktree create --branch"

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

    fish_config theme choose 'Solarized Osaka Dark'

    set -x FZF_DEFAULT_OPTS "--color=bg+:#002c38,bg:#001419,spinner:#c94c16,hl:#c94c16 --color=fg:#9eabac,header:#c94c16,info:#637981,pointer:#c94c16 --color=marker:#c94c16,fg+:#adb7b7,prompt:#c94c16,hl+:#c94c16 --color=selected-bg:#063540 --color=border:#063540,label:#9eabac,gutter:#001419,scrollbar:#063540,separator:#063540"
end
