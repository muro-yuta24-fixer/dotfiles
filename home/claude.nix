{ config, pkgs, ... }:

{
  programs.claude-code = {
    enable = true;
    settings = {
      enabledPlugins = {
        "frontend-design@claude-plugins-official" = true;
        "code-review@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
        "code-simplifier@claude-plugins-official" = true;
        "commit-commands@claude-plugins-official" = true;
        "pr-review-toolkit@claude-plugins-official" = true;
        "pyright-lsp@claude-plugins-official" = true;
        "csharp-lsp@claude-plugins-official" = true;
        "rust-analyzer-lsp@claude-plugins-official" = true;
        "claude-code-setup@claude-plugins-official" = true;
        "feature-dev@claude-plugins-official" = true;
        "gopls-lsp@claude-plugins-official" = true;
        "microsoft-docs@claude-plugins-official" = true;
      };
      language = "Japanese";
      autoUpdatesChannel = "stable";
      env = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
  };

  programs.codex = {
    enable = true;
    settings = {
      personality = "pragmatic";
      features = {
        undo = true;
      };
    };
  };
}
