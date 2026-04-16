{ lib, pkgs, ... }:
{
  imports = [
    ./lsp.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;

    dependencies = {
      direnv.enable = true;
      fd.enable = true;
      fzf.enable = true;
      git.enable = true;
      nodejs.enable = true;
      ripgrep.enable = true;
      tree-sitter.enable = true;
    };

    opts = {
      encoding = "utf-8";
      fileencoding = "utf-8";
      number = true;
      relativenumber = true;
      hlsearch = true;
      backup = false;
      cmdheight = 0;
      laststatus = 0;
      expandtab = true;
      smarttab = true;
      breakindent = true;
      shiftwidth = 2;
      tabstop = 2;
      autoindent = true;
      smartindent = true;
      wrap = true;
      backspace = "start,eol,indent";
      cursorline = true;
      termguicolors = true;
      winblend = 0;
      wildoptions = "pum";
      pumblend = 5;
      background = "light";
      statusline = "─";
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      # スペースのデフォルト動作を無効化
      {
        mode = [
          "n"
          "v"
        ];
        key = "<Space>";
        action = "<NOP>";
        options.silent = true;
      }
      # Emacs-like cursor in insert mode
      {
        mode = "i";
        key = "<C-f>";
        action = "<Right>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<C-b>";
        action = "<Left>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<C-p>";
        action = "<Up>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<C-n>";
        action = "<Down>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<C-a>";
        action = "<Home>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<C-e>";
        action = "<End>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<A-f>";
        action = "<C-Right>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<A-b>";
        action = "<C-Left>";
        options.silent = true;
      }

      # Split
      {
        mode = "n";
        key = "ss";
        action = ":split<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "sv";
        action = ":vsplit<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }

      # Move windows
      {
        mode = "n";
        key = "sh";
        action = "<C-w>h";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "sj";
        action = "<C-w>j";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "sk";
        action = "<C-w>k";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "sl";
        action = "<C-w>l";
        options = {
          silent = true;
          noremap = true;
        };
      }

      # Tab
      {
        mode = "n";
        key = "te";
        action = ":tabedit %<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<Tab>";
        action = "gt";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "gT";
      }

      # Redo
      {
        mode = "n";
        key = "U";
        action = "<C-r>";
        options = {
          silent = true;
          noremap = true;
        };
      }

      # Don't yank with x
      {
        mode = "n";
        key = "x";
        action = "\"_x";
      }

      # Save with q
      {
        mode = "n";
        key = "q";
        action = ":w<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }

      # Terminal escape
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
      }
    ];

    performance = {
      byteCompileLua = {
        enable = true;
      };
    };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        disable_underline = true;
      };
    };
  };
}
