{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.postgresql = {
    enable = true;
    extraPlugins = [
      pkgs.postgresqlPackages.pgvector
    ];
  };
}
