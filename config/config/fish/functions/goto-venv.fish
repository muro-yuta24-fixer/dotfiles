function goto-venv
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
