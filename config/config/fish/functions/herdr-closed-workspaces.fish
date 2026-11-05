function herdr-closed-workspaces
    # herdrが入っているか確かめる
    if not type herdr >/dev/null 2>&1
        echo "Herdr not found."
        return 127
    end
    # jqが入っているか確かめる
    if not type jq >/dev/null 2>&1
        echo "jq not found."
        return 127
    end

    herdr worktree list | jq -r ".result.worktrees[] | select(.open_workspace_id==null) | .path"
end
