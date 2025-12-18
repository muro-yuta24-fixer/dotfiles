function ghq-tmux
    set -l repository (ghq root)/(ghq list | fzf --layout=reverse)

    if test -z "$repository"
        return 0
    end

    set -l session_name (basename $repository)

    # セッションが存在するか確認
    if tmux has-session -t $session_name 2>/dev/null
        # 既存のセッションにアタッチ
        tmux attach-session -t $session_name
    else
        # 新しいセッションを作成（作業ディレクトリを指定）
        tmux new-session -s $session_name -c $repository
    end
end
