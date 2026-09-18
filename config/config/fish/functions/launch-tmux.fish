function launch-tmux
    if test (count $argv) -eq 0
        tmux new-session -A -s (basename (pwd))
    else
        tmux new-session -A -s $argv[1]
    end
end
