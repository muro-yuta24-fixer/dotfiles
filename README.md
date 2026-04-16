# dotfiles

NixOSでシステムとhome-managerを管理するための設定ファイル群。

## 構成

```
flake.nix                   # フレークのエントリポイント
├── system/
│   └── default.nix         # 全ホスト共通のシステム設定
├── hosts/
│   ├── nixos-wsl/          # WSL用ホスト設定
│   │   ├── default.nix
│   │   └── ffmpeg.nix
│   └── server/             # サーバー用ホスト設定
│       └── default.nix
├── home/                   # home-manager設定
│   ├── default.nix         # 共通設定 (shell, git, cli, tmux, claude等)
│   ├── desktop.nix         # デスクトップ専用 (google-chrome, yt-dlp)
│   └── ...
└── nixvim/                 # Neovim設定
    ├── default.nix
    ├── lsp.nix
    └── plugins.nix
```

利用可能なホスト:

- `nixos-wsl` — WSL2上のNixOS (デスクトップツール込み)
- `server` — 仮想マシン等で動かすサーバー用の最小構成

## NixOS-WSLへの導入

### 1. NixOS-WSLのインストール

[NixOS-WSL](https://github.com/nix-community/NixOS-WSL) のリリースから `nixos-wsl.wsl` をダウンロードして展開する。

```powershell
# PowerShell
wsl --install --from-file nixos-wsl.wsl
wsl -d NixOS
```

### 2. このリポジトリをクローン

```sh
nix-shell -p git
git clone https://github.com/muro-yuta24-fixer/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. 設定を適用

```sh
sudo nixos-rebuild switch --flake .#nixos-wsl
```

切り替わったらWSLを再起動して反映させる。

```powershell
# PowerShell
wsl --shutdown
wsl -d NixOS
```

## Serverへの導入

仮想マシン上で動かすシンプルなサーバー向けの手順。

### 1. NixOSのインストール

[NixOS公式ISO](https://nixos.org/download/) (minimal) をVMにマウントして起動し、通常のインストール手順でセットアップする。ユーザー名は `nixos` を想定している。

### 2. hardware-configuration.nixの生成

VMに合わせたディスク/ブートローダー設定が必要なので、インストール時に生成される `/etc/nixos/hardware-configuration.nix` をこのリポジトリに取り込む。

```sh
sudo nixos-generate-config --show-hardware-config > hosts/server/hardware-configuration.nix
```

### 3. hosts/server/default.nixの調整

`hosts/server/default.nix` は暫定で `boot.loader.grub` と `fileSystems."/"` を定義しているので、以下の手順で置き換える:

1. 仮のブロック (`boot.loader.grub` と `fileSystems."/"`) を削除
2. `imports` のコメントアウトを外して `./hardware-configuration.nix` を有効化

```nix
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "server";

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
```

SSHキー認証のみを許可する設定になっているので、事前に `users.users.nixos.openssh.authorizedKeys.keys` を追加しておくか、初回は一時的に `PasswordAuthentication = true;` にしておく。

### 4. リポジトリをクローンして適用

```sh
nix-shell -p git
git clone https://github.com/muro-yuta24-fixer/dotfiles.git ~/dotfiles
cd ~/dotfiles
sudo nixos-rebuild switch --flake .#server
```

## よく使うコマンド

```sh
# 設定の検証 (ビルドできるかだけ確認)
nix flake check

# フレーク入力の更新
nix flake update

# 設定を適用
sudo nixos-rebuild switch --flake .#<host>

# 一時的に試す (再起動で元に戻る)
sudo nixos-rebuild test --flake .#<host>
```

## 新しいホストの追加

1. `hosts/<hostname>/default.nix` を作成し、ホスト固有の設定を記述
2. `flake.nix` の `nixosConfigurations` に追加

```nix
<hostname> = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    home-manager.nixosModules.home-manager
    ./system
    ./hosts/<hostname>
    {
      nixpkgs.overlays = [ nix-claude-code.overlays.default ];

      home-manager.useGlobalPkgs = true;
      home-manager.users.nixos = {
        imports = homeModules;  # デスクトップ用途なら ++ [ ./home/desktop.nix ]
      };
    }
  ];
};
```
