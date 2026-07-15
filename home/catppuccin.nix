{ config, pkgs, ... }:

{
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
    alacritty.enable = true;
  };
}
