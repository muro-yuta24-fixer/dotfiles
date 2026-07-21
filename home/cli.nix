{ config, pkgs, ... }:

{
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.mise = {
    # enable = true;
    enable = false;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    # mise.enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.btop = {
    enable = true;
    package = null;
    settings = {
      update_ms = 100;
      mem_graphs = false;
    };
  };

  programs.pandoc = {
    enable = true;
  };
}
