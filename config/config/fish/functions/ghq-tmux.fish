function ghq-tmux
    set -l repository (ghq root)/(ghq list | fzf --layout=reverse)

    if test -z "$repository"
        return 0
    end

    set -l session_name (basename $repository)

    tmux new-session -A -s $session_name -c $repository
end
