{ config, pkgs, ... }:

let
  browser = "/mnt/c/Program\\ Files\\ \\(x86\\)/Microsoft/Edge/Application/msedge.exe";
in

{
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

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };
}
