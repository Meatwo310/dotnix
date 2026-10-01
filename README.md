# dotnix

[![Build and Check](https://github.com/Meatwo310/dotnix/actions/workflows/build.yml/badge.svg)](https://github.com/Meatwo310/dotnix/actions/workflows/build.yml)
[![Static Checks](https://github.com/Meatwo310/dotnix/actions/workflows/static-check.yml/badge.svg)](https://github.com/Meatwo310/dotnix/actions/workflows/static-check.yml)
[![Pinact](https://github.com/Meatwo310/dotnix/actions/workflows/pinact.yml/badge.svg)](https://github.com/Meatwo310/dotnix/actions/workflows/pinact.yml)
[![works on my machine badge](https://cdn.jsdelivr.net/gh/nikku/works-on-my-machine@v0.4.0/badge.svg)](https://github.com/nikku/works-on-my-machine)
[![NixOS](https://img.shields.io/badge/NixOS-flakes-4D6FB7?logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![Cachix](https://img.shields.io/badge/cachix-meatwo310--dotnix-blue)](https://meatwo310-dotnix.cachix.org)

NixOS / nix-darwin を対象とした複数ホスト対応の Nix Flake 設定リポジトリです。  
linux-surface などの自動ビルド・キャッシュも行います。

## 対応ホスト

| ホスト名         | OS                 | アーキテクチャ   　　　　　| 備考                          |
|--------------|--------------------|----------------|-----------------------------|
| `sp9-v7`     | NixOS              | x86_64-linux   | Microsoft Surface Pro 9     |
| `gaming-wsl` | NixOS (WSL)        | x86_64-linux   | Windows Subsystem for Linux |
| `m2air`      | macOS (nix-darwin) | aarch64-darwin | MacBook Air M1              |

## バイナリキャッシュ

ビルド済みパッケージは Cachix で公開されています。

- **URL**: https://meatwo310-dotnix.cachix.org
- **公開鍵**: `meatwo310-dotnix.cachix.org-1:F4Stc7Ivxgl72SHWe8z0pOHAe8Ip7zMFgOK6hdkh26k=`

## セットアップ

### 事前準備（全ホスト共通）

```sh
# リポジトリをクローン
git clone https://github.com/Meatwo310/dotnix ~/dotnix
cd ~/dotnix
```

---

### NixOS（`sp9-v7` / `gaming-wsl`）

#### 初回適用時

初回はフレークの `nix.settings` がまだ適用されていないため、**キャッシュが自動では使われません**。  
substituter を明示的に指定して実行してください。

```sh
HOSTNAME=sp9-v7

sudo nixos-rebuild switch --flake ~/dotnix#$HOSTNAME \
  --option extra-substituters "https://nix-community.cachix.org https://meatwo310-dotnix.cachix.org" \
  --option extra-trusted-public-keys "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= meatwo310-dotnix.cachix.org-1:F4Stc7Ivxgl72SHWe8z0pOHAe8Ip7zMFgOK6hdkh26k="
```

#### 2回目以降の更新

```sh
nh os switch
```

---

### macOS / nix-darwin（`m2air`）

#### Nix をインストール

[Nix 公式の macOS 向け手順](https://nixos.org/download/):

```sh
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon
```

#### 初回適用

```sh
nix run --extra-experimental-features "nix-command flakes" nixpkgs#git -- \
  clone https://github.com/Meatwo310/dotnix ~/dotnix
cd ~/dotnix
```

Homebrew は自動でインストールされ、導入済みの場合は既存パッケージを引き継ぎます。

```sh
sudo nix run --extra-experimental-features "nix-command flakes" \
  nix-darwin/master#darwin-rebuild -- switch --flake ~/dotnix#m2air \
  --option extra-substituters "https://nix-community.cachix.org https://meatwo310-dotnix.cachix.org" \
  --option extra-trusted-public-keys "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= meatwo310-dotnix.cachix.org-1:F4Stc7Ivxgl72SHWe8z0pOHAe8Ip7zMFgOK6hdkh26k="
```

#### 2回目以降の更新

```sh
nh darwin switch
```

---

## 開発

### Git と SSH キー

Git の名義は全ホスト共通で `Meatwo310 <git@meatwo310.net>` とし、コミットはデフォルトで SSH 署名します。
公開鍵は Home Manager で管理します。対応する秘密鍵は各ホストに手動で配置してください。

| 秘密鍵の配置先 | 用途 | 公開鍵のコメント |
| --- | --- | --- |
| `~/.ssh/id_ed25519` | 通常の SSH 認証 | `key@meatwo310.net` |
| `~/.ssh/id_ed25519_git` | Git コミット署名 | `git@meatwo310.net` |
| `~/.ssh/id_ed25519_github` | GitHub 認証 | `GitHub Authentication` |

通常の SSH キーは標準のファイル名なので、追加の `IdentityFile` 設定は不要です。
署名の検証には、管理された `~/.ssh/allowed_signers` を使用します。

### 開発環境

`nixfmt`、`nixfmt-tree`、`statix`、`deadnix`を含む開発環境を起動します。

```sh
nix develop
```

### 静的チェック

静的チェックはリポジトリのルートで実行します。

```sh
nix run .#statix
nix run .#deadnix
nix run .#nixfmt-check
```

3つをまとめて実行する場合は次を使います。途中のチェックが失敗しても残りを実行し、
いずれかが失敗した場合は終了コード1を返します。

```sh
nix run .#check
```

`nixfmt-check` はファイルを整形し、変更が発生すると失敗します。

自動生成される `hardware-configuration.nix` は `statix` と整形の対象から除外しています。
`deadnix` は `hosts/*/hardware-configuration.nix` を除外します。

### 整形

リポジトリ内の Nix ファイルを `nixfmt-tree` で一括整形します。除外設定は整形チェックと共通です。

```sh
nix fmt
```

単一ファイルを整形する場合は、開発環境内で実行します。

```sh
nixfmt flake.nix
```

VS Code と `nil` も `nixfmt` を使用します。

### Flake inputの更新

通常のパッケージとSurfaceカーネルは、それぞれ別の`nixpkgs` inputに固定しています。
通常の更新では、カーネル用のinputを含めずに更新してください。

```sh
nix flake update nixpkgs home-manager plasma-manager zen-browser \
  codex-desktop-linux vscode-server nixos-wsl nix-darwin
```

Surfaceカーネルを更新する場合は、カーネル用の`nixpkgs`と`nixos-hardware`を一緒に更新します。

```sh
nix flake update kernel-nixpkgs nixos-hardware
```

---

## CI

GitHub Actions によりプッシュのたびに全ホストの設定をビルド・検証しています。  
ビルド結果は Cachix (`meatwo310-dotnix`) にプッシュされます。

```
nix flake check → ヘビーなカスタムパッケージのビルド → 各ホストのトップレベルビルド
```

独立した `Static Checks` ワークフローで、ローカルと同じ `statix`・`deadnix`・`nixfmt-check` の app を実行します。
あるチェックが失敗しても残りのチェックを実行します。ビルド CI も継続します。
