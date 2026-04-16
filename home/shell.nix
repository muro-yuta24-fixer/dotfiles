{ config, pkgs, ... }:

let
  browser = "/mnt/c/Program\\ Files\\ \\(x86\\)/Microsoft/Edge/Application/msedge.exe";
in

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "emacs";
    history = {
      append = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 100000000;
      saveNoDups = false;
      size = 100000000;
    };
    historySubstringSearch = {
      enable = true;
    };
    plugins = [
      {
        name = "spaceship";
        src = pkgs.spaceship-prompt;
        file = "share/zsh/site-functions/prompt_spaceship_setup";
      }
    ];
    siteFunctions = {
      launch-tmux = ''
        if [[ $# -eq 0 ]]; then
          tmux new-session -A -s "''${PWD##*/}"
        else
          tmux new-session -A -s "$1"
        fi
      '';
      ghq-tmux = ''
        local repository="$(ghq root)/$(ghq list | fzf --layout=reverse)"

        if [[ -z "$repository" || "$repository" == "$(ghq root)/" ]]; then
          return 0
        fi

        local session_name="''${repository##*/}"

        tmux new-session -A -s "$session_name" -c "$repository"
      '';
    };
    sessionVariables = {
      BROWSER = browser;
      EDITOR = "vim";
    };
    shellAliases = {
      c = "cd";
      md = "mkdir";
      g = "git";
      v = "nvim";
    };
    syntaxHighlighting = {
      enable = true;
    };
    zsh-abbr = {
      enable = true;
      abbreviations = {
        dp = "docker compose";
        gpv = "gh pr view -w";
        gco = "gh pr checkout";
        tm = "launch-tmux";
        gl = "ghq-tmux";
        da = "direnv allow";
      };
    };
  };

  programs.vim = {
    enable = true;
    settings = {
      background = "light";
      mouse = "a";
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
    };
  };
}
