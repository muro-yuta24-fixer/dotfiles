{ pkgs, nixpkgs-unstable, ... }:

let
  unstable = import nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  services.ollama = {
    enable = true;
    package = unstable.ollama-cpu;
    openFirewall = true;
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "0"; # モデルをすぐにアンロードする
      OLLAMA_CONTEXT_LENGTH = "65536"; # コンテキスト幅
      OLLAMA_NUM_PARALLEL = "1"; # 同時に受けるリクエストの数
      OLLAMA_NEW_ENGINE = "1";
    };
  };
}
