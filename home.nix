{ config, pkgs, ... }:

let
  browser = "/mnt/c/Program\\ Files\\ \\(x86\\)/Microsoft/Edge/Application/msedge.exe";
in

{
  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nodejs

    pnpm
    biome
    uv
    sd
    dust
    ghq

    zstd
    p7zip
    parallel

    google-chrome

    awscli2

    nixfmt
  ];

  home.sessionVariables = {
    BROWSER = browser;
    EDITOR = "vim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

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

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Y.Muro";
        email = "165998973+muro-yuta24-fixer@users.noreply.github.com";
      };
      core = {
        autocrlf = "input";
        editor = "nvim";
      };
      alias = {
        a = "add";
        al = "add --all";
        d = "diff";
        ds = "diff --staged";
        co = "checkout";
        cm = "commit";
        br = "branch";
        ba = "branch -a";
        sw = "switch";
        l = "log --oneline";
        lg = "log";
        r = "restore";
        rs = "restore --staged";
        cl = "clone";
        st = "status";
        fh = "fetch";
        pl = "pull";
        rb = "rebase";
        ps = "push";
        pu = "push -u origin HEAD";
        sh = "stash";
        sp = "stash pop";
        rv = "revert";
        wt = "worktree";
        clean-branch = "!git branch | grep -v '$(git branch --show-current)' | grep -v 'develop' | grep -v 'master' | grep -v 'main' | xargs git branch -D";
        hist = "log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(red)%s %C(bold red){{%an}}%C(reset) %C(blue)%d%C(reset)' --graph --date=short";
      };
      push = {
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };
      ghq = {
        root = "~/.ghq";
      };
    };
    ignores = [
      "00yuta-*.sh"
      ".env"

      "**/.claude/settings.local.json"

      "mise.local.toml"
    ];
  };

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      blocks = [
        "permission"
        "user"
        "group"
        "size"
        "date"
        "name"
      ];
      dereference = true;
      icons = {
        when = "always";
        theme = "fancy";
      };
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };
  programs.ripgrep-all = {
    enable = true;
  };

  programs.fd = {
    enable = true;
    hidden = true;
  };

  programs.fastfetch = {
    enable = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "Catppuccin Latte";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
    settings = {
      git_protocol = "https";
      editor = "nvim";
      prompt = "enabled";
      browser = browser;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };


  programs.btop = {
    enable = true;
    settings = {
      update_ms = 100;
      mem_graphs = false;
      show_disks = false;
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-x";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    keyMode = "vi";
    historyLimit = 100000000;
    focusEvents = true;
    extraConfig = ''
      # Truecolor settings
      set -ag terminal-overrides ",xterm-256color:RGB"

      # Split window vertical
      bind h split-window -h

      # Split window horizontal
      bind v split-window -v

      set -g mode-style "fg=blue,bg=#ccd0da"

      set -g message-style "fg=blue,bg=#ccd0da"
      set -g message-command-style "fg=blue,bg=#ccd0da"

      set -g pane-border-style "fg=#ccd0da"
      set -g pane-active-border-style "fg=blue"

      set -g status "on"
      set -g status-justify "left"

      set -g status-style "fg=blue"

      set -g status-left-length "100"
      set -g status-right-length "500"

      set -g status-left-style NONE
      set -g status-right-style NONE

      set -g status-left "#[fg=#eff1f5,bg=#1e66f5,bold] #h #[fg=#1e66f5,bg=#eff1f5,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#1e66f5,bg=#eff1f5,nobold,nounderscore,noitalics]#[fg=#eff1f5,bg=#1e66f5,bold] #S "

      setw -g window-status-activity-style "underscore,fg=#9ca0b0,bg=#eff1f5"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#9ca0b0"
      setw -g window-status-format "#[fg=#eff1f5,bg=#eff1f5,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#eff1f5,bg=#eff1f5,nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#eff1f5,bg=#ccd0da,nobold,nounderscore,noitalics]#[fg=#1e66f5,bg=#ccd0da,bold] #I  #W #F #[fg=#ccd0da,bg=#eff1f5,nobold,nounderscore,noitalics]"
    '';
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yt-dlp = {
    enable = true;
    settings = {
      output = "$HOME/Videos/YouTube/%(channel)s/%(title)s.%(ext)s";
      sleep-interval = 5;
      max-sleep-interval = 20;
      format = "bestvideo+bestaudio";
      # cookies-from-browser = "chrome";
      embed-metadata = true;
      write-thumbnail = true;
    };
  };

  catppuccin = {
    flavor = "latte";
    lsd.enable = true;
    bat.enable = true;
    delta.enable = true;
    btop.enable = true;
    fzf.enable = true;
    zsh-syntax-highlighting.enable = true;
    tmux.enable = true;
    lazygit.enable = true;
    nvim.enable = true;
  };

  programs.claude-code = {
    enable = true;
    settings = {
      enabledPlugins = {
        "frontend-design@claude-plugins-official" = true;
        "code-review@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
        "code-simplifier@claude-plugins-official" = true;
        "commit-commands@claude-plugins-official" = true;
        "pr-review-toolkit@claude-plugins-official" = true;
        "pyright-lsp@claude-plugins-official" = true;
        "csharp-lsp@claude-plugins-official" = true;
        "rust-analyzer-lsp@claude-plugins-official" = true;
        "claude-code-setup@claude-plugins-official" = true;
        "feature-dev@claude-plugins-official" = true;
        "gopls-lsp@claude-plugins-official" = true;
        "microsoft-docs@claude-plugins-official" = true;
      };
      language = "Japanese";
      autoUpdatesChannel = "stable";
      env = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
  };

  programs.codex = {
    enable = true;
    settings = {
      personality = "pragmatic";
      features = {
        undo = true;
      };
    };
  };

  programs.pandoc = {
    enable = true;
  };
}
