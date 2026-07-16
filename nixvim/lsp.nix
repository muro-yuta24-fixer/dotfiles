{ lib, pkgs, ... }:
{
  programs.nixvim = {
    lsp = {
      inlayHints = {
        enable = true;
      };
      servers = {
        # 全サーバ共通の設定。neovim が vim.tbl_deep_extend で各サーバにマージする。
        # blink-cmp の capabilities を全 LSP に伝播させる。
        "*" = {
          config = {
            capabilities.__raw = ''require("blink-cmp").get_lsp_capabilities()'';
          };
        };
        basedpyright = {
          enable = true;
          activate = true;
        };
        biome = {
          enable = true;
          activate = true;
        };
        # docker_compose_language_service = {
        #   enable = true;
        #   activate = true;
        # };
        # docker_language_server = {
        #   enable = true;
        #   activate = true;
        # };
        eslint = {
          enable = true;
          activate = true;
        };
        nixd = {
          enable = true;
          activate = true;
        };
        oxlint = {
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
  };
}
