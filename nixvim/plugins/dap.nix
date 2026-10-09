{ ... }:

{
  programs.nixvim.plugins = {
    dap = {
      enable = true;
    };
    dap-view = {
      enable = true;
    };
  };
}
