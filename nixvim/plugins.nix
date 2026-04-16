{ lib, pkgs, ... }:
{
  programs.nixvim = {
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
            close_icon = "";
            left_trunc_marker = "";
            right_trunc_marker = "";
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
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
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
                # symbols = {
                #   error = " "; # nf-oct-bug
                #   warn = " "; # nf-oct-alert
                #   info = " "; # nf-oct-info
                #   hint = " "; # nf-oct-light_bulb
                # };
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
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
            inc_rename = true;
            lsp_doc_border = true;
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
                "<C-g>" = {
                  __raw = "require('telescope.actions').close";
                };
              };
              n = {
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
