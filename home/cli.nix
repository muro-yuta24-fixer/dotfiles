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

  programs.pandoc = {
    enable = true;
  };
}
