# dotnix

NixOS / nix-darwin を対象とした複数ホスト対応の Nix Flakes 設定リポジトリです。  
linux-surfaceなどの自動ビルド・キャッシュも行います。

## 対応ホスト

| ホスト名         | OS                 | アーキテクチャ   　　　　　| 備考                          |
|--------------|--------------------|----------------|-----------------------------|
| `sp9-v7`     | NixOS              | x86_64-linux   | Microsoft Surface Pro 9     |
| `gaming-wsl` | NixOS (WSL)        | x86_64-linux   | Windows Subsystem for Linux |
| `m2air`      | macOS (nix-darwin) | aarch64-darwin | MacBook Air M1              |

## バイナリキャッシュ

ビルド済みパッケージは Cachix で公開されています。

- **URL**: `https://meatwo310-dotnix.cachix.org`
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
  --option substituters "https://cache.nixos.org https://nix-community.cachix.org https://meatwo310-dotnix.cachix.org" \
  --option trusted-public-keys "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= meatwo310-dotnix.cachix.org-1:F4Stc7Ivxgl72SHWe8z0pOHAe8Ip7zMFgOK6hdkh26k="
```

#### 2回目以降の更新

```sh
nh os switch
```

---

### macOS / nix-darwin（`m2air`）

#### 初回セットアップ

```sh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/dotnix#m2air \
  --option accept-flake-config true
```

`accept-flake-config true` を付けることで、フレーク内の `nix.settings`（substituters / trusted-public-keys）が初回から読み込まれ、Cachix キャッシュが利用されます。

#### 2回目以降の更新

<!-- TODO: darwinでもnhをセットアップし、それを使用する方法に書き換える -->

```sh
sudo darwin-rebuild switch --flake ~/dotnix#m2air
```

---

## CI

GitHub Actions によりプッシュのたびに全ホストの設定をビルド・検証しています。  
ビルド結果は Cachix (`meatwo310-dotnix`) にプッシュされます。

```
nix flake check → ヘビーなカスタムパッケージのビルド → 各ホストのトップレベルビルド
```
