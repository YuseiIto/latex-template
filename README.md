# LuaTeX Project Template

[![Build and Publish Docker Image](https://github.com/YuseiIto/latex-template/actions/workflows/build-image.yml/badge.svg)](https://github.com/YuseiIto/latex-template/actions/workflows/build-image.yml)

[![reviewdog](https://github.com/YuseiIto/latex-template/actions/workflows/reviewdog.yml/badge.svg)](https://github.com/YuseiIto/latex-template/actions/workflows/reviewdog.yml)

@yuseiito が LaTeX 文書を作成する際の設定を簡略化するために作成したテンプレートです。日本語文書の生成を念頭に作成しています。 

## Requirements
- Docker
  - コンテナによるビルド環境を提供するために利用する
- GNU Make
  - 成果物の生成/削除といったビルドを実行するためのタスクランナーとして利用する
- Node / npm（Node 20 以上）
  - `textlint`による自動校正を実現するために利用する

## 使い方

### セットアップ

リポジトリを clone したら、初めに`npm`パッケージをインストールして、LuaTeX を含んだ Docker イメージを作成します。

```zsh
make setup
```

### 文書のビルド

```zsh
make all
```

先に`make setup`が正常に完了していれば文書のみが生成されますが、`.image-built`ファイルがない場合は再度イメージを作成してからビルドします。再コンパイルの回数や`pbibtex`の実行は[latexmk](https://ctan.org/pkg/latexmk)が自動で判定します（設定は`src/.latexmkrc`）。

LaTeX 文書は、`src/`以下に置いてください。ビルド対象の`.tex`ファイルは Makefile 中の`ENTRYPOINTS`で指定します。


### 文書の校正
このプロジェクトには[textlint](https://textlint.github.io/)による自動校正用の設定が実装されています。

次のようにして自動構成によるエラー指摘が得られます。

```zsh
% make test
```

また、一部の問題は次のようにすることで自動修正されます。

```
make format
```

### Cleanup

生成ファイルは、次のコマンドで cleanup できます。

```zsh
make clean
```

## VSCode Support
本プロジェクトは、Requirements で挙げたプログラム以外に、エディタとして VSCode を使用することを想定して、[LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)などの拡張機能を設定してあります。適宜使用してください。

また、[Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)用の`.devcontainer/`を同梱しています。VSCode で "Reopen in Container" を実行すると、TeX Live と Node を含むコンテナ内で編集・ビルド・校正が完結します。


## CI workflow
また、本プロジェクトには GitHub Actions による CI 機能が設定されています。 [reviewdog](https://github.com/reviewdog/reviewdog)が、プルリクエストに含まれた校正上のエラーを検知し指摘します。


## そのほかの技術的詳細
### Docker Imageについて

このプロジェクトでは、[TeX Live](https://www.tug.org/texlive/)を Ubuntu 上でホストする docker コンテナを利用します。

次のコマンドでビルドされ、その名前は`yuseiito/texlive-ubuntu`です。

```zsh
make image
```


GitHub Container Registry 上でもビルド済みコンテナを提供しています。次のように入手できます。

```zsh
docker pull ghcr.io/yuseiito/texlive-ubuntu:latest
```

## Licence
このテンプレートのうち、このテンプレートリポジトリに格納されたデータは CC0 ライセンスで配布します。(ただし、このリポジトリが読み込む各コンポーネントはそれぞれ別のライセンスで保護されている場合があります)

このテンプレートを用いて文書を公開される場合は、`LICENCE`ファイルおよび本ファイル下部のライセンスに関する記述を削除するか置き換えて、ご自身の文書の権利をご自身の責任で保護してください。
