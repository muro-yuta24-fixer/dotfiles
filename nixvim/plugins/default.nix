{ lib, pkgs, ... }:
{
  imports = [
    ./cmp.nix
    ./bufferline.nix
    ./lualine.nix
    ./notify.nix
    ./telescope.nix
  ];

  programs.nixvim = {
    plugins = {
      aerial = {
        enable = true;
      };
      colorizer = {
        enable = true;
      };
      comment = {
        enable = true;
      };
      direnv = {
        enable = true;
        settings = {
          direnv_auto = 1;
          direnv_silent_load = 1;
        };
      };
      git-conflict = {
        enable = true;
        settings = {
          default_command = true;
          default_mappings = false;
        };
      };
      gitsigns = {
        enable = true;
      };
      indent-blankline = {
        enable = true;
      };
      lsp = {
        enable = true;
      };
      lsp-format = {
        enable = true;
      };
      neogit = {
        enable = true;
      };
      nix = {
        enable = true;
      };
      nvim-autopairs = {
        enable = true;
      };
      rainbow-delimiters = {
        enable = true;
      };
      render-markdown = {
        enable = true;
      };
      todo-comments = {
        enable = true;
      };
      treesitter = {
        enable = true;
        settings = {
          highlight = {
            enable = true;
          };
          indent = {
            enable = true;
          };
        };
      };
      ts-autotag = {
        enable = true;
      };
      web-devicons = {
        enable = true;
      };
      which-key = {
        enable = true;
      };
    };
  };
}
