{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    google-chrome
  ];

  programs.yt-dlp = {
    enable = true;
    settings = {
      output = "$HOME/Videos/YouTube/%(channel)s/%(title)s.%(ext)s";
      sleep-interval = 5;
      max-sleep-interval = 20;
      format = "bestvideo+bestaudio";
      embed-metadata = true;
      write-thumbnail = true;
    };
  };
}
