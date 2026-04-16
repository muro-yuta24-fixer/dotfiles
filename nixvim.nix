# nixvim.nix
{ lib, pkgs, ... }:
{
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

    lsp = {
      inlayHints = {
        enable = true;
      };
      servers = {
        basedpyright = {
          enable = true;
          activate = true;
        };
        biome = {
          enable = true;
          activate = true;
        };
        docker_compose_language_service = {
          enable = true;
          activate = true;
        };
        docker_language_server = {
          enable = true;
          activate = true;
        };
        eslint = {
          enable = true;
          activate = true;
        };
        nixd = {
          enable = true;
          activate = true;
        };
        roslyn_ls = {
          enable = true;
          activate = true;
        };
        ruff = {
          enable = true;
          activate = true;
        };
        rust_analyzer = {
          enable = true;
          activate = true;
        };
        tailwindcss = {
          enable = true;
          activate = true;
        };
        ts_ls = {
          enable = true;
          activate = true;
        };
      };
      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gD";
          lspBufAction = "references";
        }
        {
          key = "gt";
          lspBufAction = "type_definition";
        }
        {
          key = "gi";
          lspBufAction = "implementation";
        }
        {
          key = "K";
          lspBufAction = "hover";
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
        }
      ];
    };

    plugins = {
      aerial = {
        enable = true;
      };
      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        settings = {
          keymap = {
            preset = "default";
          };
          appearance = {
            nerd_font_variant = "normal";
          };
          completion = {
            accept = {
              auto_brackets = {
                enabled = true;
              };
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 100;
              treesitter_highlighting = true;
              update_delay_ms = 50;
              window = {
                border = "rounded";
                scrollbar = true;
              };
            };
            ghost_text = {
              enabled = true;
            };
            menu = {
              enabled = true;
              auto_show = true;
              border = "rounded";
            };
          };
          fuzzy = {
            prebuilt_binaries = {
              download = true;
            };
          };
          signature = {
            enabled = true;
            window = {
              border = "rounded";
            };
          };
          sources = {
            default = [
              "lsp"
              "snippets"
              "buffer"
            ];
            per_filetype = {
              bash = [
                "buffer"
                "path"
              ];
              sh = [
                "buffer"
                "path"
              ];
            };
          };
        };
      };
      bufferline = {
        enable = true;
        settings = {
          options = {
            mode = "tabs";
            numbers = "buffer_id";
            indicator = {
              style = "icon";
            };
            buffer_close_icon = "󰅖";
            modified_icon = "●";
            close_icon = "";
            left_trunc_marker = "";
            right_trunc_marker = "";
            diagnostics = "nvim_lsp";
            offsets = { };
            color_icons = true;
            show_buffer_icons = true;
            show_buffer_close_icons = false;
            show_close_icons = false;
            show_tab_indicators = false;
            show_duplicate_prefix = false;
            separator_style = "slant";
            always_show_bufferline = true;
            sort_by = "tabs";
          };
        };
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
      lualine = {
        enable = true;
        settings = {
          options = {
            icons_enabled = true;
            theme = "auto";
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
            always_divide_middle = false;
            globalstatus = true;
            refresh = {
              statusline = 100;
              tabline = 100;
              winbar = 100;
            };
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" ];
            lualine_c = [
              {
                __unkeyed-1 = "diff";
                colored = true;
                symbols = {
                  added = "[+]";
                  modified = "[*]";
                  removed = "[-]";
                };
              }
              {
                __unkeyed-1 = "filename";
                file_status = false;
                newfile_status = false;
                path = 1;
              }
            ];
            lualine_x = [
              "filetype"
              {
                __unkeyed-1 = "diagnostics";
                sources = [
                  "nvim_diagnostic"
                  "nvim_lsp"
                ];
                symbols = {
                  error = " "; # nf-oct-bug
                  warn = " "; # nf-oct-alert
                  info = " "; # nf-oct-info
                  hint = " "; # nf-oct-light_bulb
                };
                colored = true;
                update_in_insert = true;
                always_visible = true;
              }
            ];
            lualine_y = [
              "encoding"
              "fileformat"
            ];
            lualine_z = [
              "progress"
              "location"
            ];
          };
        };
      };
      neogit = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings = {
            cmd = "Neogit";
            keys = [
              {
                __unkeyed-1 = "<leader>ng";
                __unkeyed-3 = "<cmd>Neogit kind=tab<cr>";
                desc = "Launch neogit";
              }
            ];
          };
        };
      };
      nix = {
        enable = true;
      };
      noice = {
        enable = true;
        settings = {
          presets = {
            bottom_search = true; # use a classic bottom cmdline for search
            command_palette = true; # position the cmdline and popupmenu together
            long_message_to_split = true; # long messages will be sent to a split
            inc_rename = true; # enables an input dialog for inc-rename.nvim
            lsp_doc_border = true; # add a border to hover docs and signature help
          };
          lsp = {
            hover.enabled = true;
            message.enabled = true;
            progress.enabled = true;
            signature.enabled = false;
          };
          messages = {
            enabled = true;
          };
        };
      };
      nvim-autopairs = {
        enable = true;
      };
      todo-comments = {
        enable = true;
      };
      telescope = {
        enable = true;
        keymaps = {
          ";f" = {
            action = "find_files";
            options = {
              desc = "Telescope find files";
            };
          };
          ";g" = {
            action = "live_grep";
            options = {
              desc = "Telescope live grep";
            };
          };
          ";b" = {
            action = "buffers";
            options = {
              desc = "Telescope buffers";
            };
          };
          ";c" = {
            action = "command_history";
            options = {
              desc = "Telescope command history";
            };
          };
          ";;" = {
            action = "file_browser path=%:p:h select_buffer=true";
            options = {
              desc = "Telescope file browser";
            };
          };
        };
        extensions = {
          file-browser = {
            enable = true;
            settings = {
              hijack_netrw = true;
              theme = "dropdown";
              initial_mode = "normal";
            };
          };
        };
        settings = {
          defaults = {
            mappings = {
              i = {
                # Mappings for insert mode
                "<C-g>" = {
                  __raw = "require('telescope.actions').close";
                };
              };
              n = {
                # Mappings for normal mode
                "q" = {
                  __raw = "require('telescope.actions').close";
                };
              };
            };
          };
          pickers = {
            find_files = {
              find_command = [
                "rg"
                "--files"
                "--hidden"
                "--glob"
                "!**/.git/*"
              ];
            };
            buffers = {
              mappings = {
                i = {
                  "<C-d>" = {
                    __raw = "require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top";
                  };
                };
              };
            };
          };
        };
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
      treesitter-context = {
        enable = true;
      };
      which-key = {
        enable = true;
      };
    };
  };
}
