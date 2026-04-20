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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";
      directory = {
        style = "blue";
      };
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };
      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
        detect_extensions = [ ];
        detect_files = [ ];
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
