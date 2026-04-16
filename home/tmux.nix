{ config, pkgs, ... }:

{
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

      set-option -g set-titles on
      set-option -g set-titles-string "#T"

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
}
