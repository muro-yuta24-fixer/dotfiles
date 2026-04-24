# dotfiles

NixOS / nix-darwinでシステムとhome-managerを管理するための設定ファイル群。

## 構成

```
flake.nix                   # フレークのエントリポイント
├── system/
│   ├── common.nix          # NixOS/Darwin共通のNix本体設定 (lix, flakes, allowUnfree)
│   └── default.nix         # NixOS専用のシステム設定
├── darwin/
│   └── default.nix         # nix-darwin共通のシステム設定
├── hosts/
│   ├── nixos-wsl/          # WSL用ホスト設定
│   │   ├── default.nix
│   │   └── ffmpeg.nix
│   ├── nix-hyperv/         # サーバー用ホスト設定
│   │   └── default.nix
│   └── yuta-macbook/       # M3 MacBook Air用ホスト設定 (nix-homebrew含む)
│       └── default.nix
├── home/                   # home-manager設定
│   ├── default.nix         # 共通設定 (shell, git, cli, tmux, claude等)
│   ├── desktop.nix         # デスクトップ専用 (google-chrome, yt-dlp)
│   ├── wsl.nix             # WSL専用 (EdgeをBROWSERに設定)
│   ├── darwin.nix          # Darwin専用 (Alacrittyなど)
│   └── ...
└── nixvim/                 # Neovim設定
    ├── default.nix
    ├── lsp.nix
    └── plugins.nix
```

利用可能なホスト:

- `nixos-wsl` — WSL2上のNixOS (デスクトップツール込み)
- `nix-hyperv` — 仮想マシン等で動かすサーバー用の最小構成
- `yuta-macbook` — M3 MacBook Air (nix-darwin + nix-homebrew)

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

## nix-hypervへの導入

仮想マシン上で動かすシンプルなサーバー向けの手順。

### 1. NixOSのインストール

[NixOS公式ISO](https://nixos.org/download/) (minimal) をVMにマウントして起動し、通常のインストール手順でセットアップする。ユーザー名は `nixos` を想定している。

### 2. hardware-configuration.nixの生成

VMに合わせたディスク/ブートローダー設定が必要なので、インストール時に生成される `/etc/nixos/hardware-configuration.nix` をこのリポジトリに取り込む。

```sh
sudo nixos-generate-config --show-hardware-config > hosts/nix-hyperv/hardware-configuration.nix
```

### 3. hosts/nix-hyperv/default.nixの調整

`hosts/nix-hyperv/default.nix` は暫定で `boot.loader.grub` と `fileSystems."/"` を定義しているので、以下の手順で置き換える:

1. 仮のブロック (`boot.loader.grub` と `fileSystems."/"`) を削除
2. `imports` のコメントアウトを外して `./hardware-configuration.nix` を有効化

```nix
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nix-hyperv";

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
sudo nixos-rebuild switch --flake .#nix-hyperv
```

## yuta-macbook (nix-darwin) への導入

M3 MacBook Air など Apple Silicon のMacにnix-darwinをセットアップする手順。

### 1. 事前準備

macOSの初期セットアップ後、ローカルユーザー `yuta` でログインした状態から始める。Command Line Toolsを入れておく。

```sh
xcode-select --install
```

### 2. Nixのインストール

[Determinate Systems Nix Installer](https://install.determinate.systems/) を使うとdaemon構成 + flakes有効化済みで導入できる。

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

インストール完了後、新しいシェルを開き直す。

### 3. リポジトリをクローン

```sh
nix run nixpkgs#git -- clone https://github.com/muro-yuta24-fixer/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 4. 初回の設定適用

nix-darwinは初回だけ `nix run` 経由で切り替える。

```sh
nix run nix-darwin/nix-darwin-25.11 -- switch --flake .#yuta-macbook
```

2回目以降は `darwin-rebuild` が使える。

```sh
darwin-rebuild switch --flake .#yuta-macbook
```

### 5. Homebrew連携について

`nix-homebrew` が有効化されているため、初回switchでHomebrew自体は自動インストールされる。Cask/Formulaは `hosts/yuta-macbook/default.nix` の `homebrew.casks` `homebrew.brews` に宣言的に追加してswitchし直す。

### 6. Lixのdaemonについて

初回switch後、Nix daemonが旧バージョンのまま動作していることがある。その場合は以下でdaemonを再起動する。

```sh
sudo launchctl kickstart -k system/org.nixos.nix-daemon
```

## よく使うコマンド

```sh
# 設定の検証 (評価エラーの確認)
nix flake check

# フレーク入力の更新
nix flake update

# NixOSの設定を適用
sudo nixos-rebuild switch --flake .#<host>

# NixOSで一時的に試す (再起動で元に戻る)
sudo nixos-rebuild test --flake .#<host>

# Darwinの設定を適用
darwin-rebuild switch --flake .#<host>
```

## 新しいホストの追加

### NixOSホスト

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

### Darwinホスト

1. `hosts/<hostname>/default.nix` を作成し、ホスト固有の設定 (hostname, nix-homebrew, homebrew, system.defaults等) を記述
2. `flake.nix` の `darwinConfigurations` に追加

```nix
<hostname> = nix-darwin.lib.darwinSystem {
  specialArgs = { inherit nixpkgs-unstable; };
  system = "aarch64-darwin";
  modules = [
    home-manager.darwinModules.home-manager
    nix-homebrew.darwinModules.nix-homebrew
    ./darwin
    ./hosts/<hostname>
    {
      nixpkgs.overlays = [ nix-claude-code.overlays.default ];

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.<user> = {
        imports = homeModules ++ [ ./home/darwin.nix ];
      };
    }
  ];
};
```
