# LuaTeX Project Template

[![Build and Publish Docker Image](https://github.com/YuseiIto/latex-template/actions/workflows/build-image.yml/badge.svg)](https://github.com/YuseiIto/latex-template/actions/workflows/build-image.yml)

[![reviewdog](https://github.com/YuseiIto/latex-template/actions/workflows/reviewdog.yml/badge.svg)](https://github.com/YuseiIto/latex-template/actions/workflows/reviewdog.yml)

@yuseiito がLaTeX文書を作成する際の設定を簡略化するために作成したテンプレートです。日本語文書の生成を念頭に作成しています。 

## Requirements
- Docker
  - コンテナによるビルド環境を提供するために利用します
- GNU Make
  - 成果物の生成/削除といったビルド作業を実行するためのタスクランナーとして利用します
- Node / npm
  - `textlint`による自動校正を実行するために利用します

## 使い方

### セットアップ

リポジトリをcloneしたら、初めに`npm`パッケージのインストールと、LuaTeXを含んだDockerイメージの作成を行います。以下のコマンドで実行されます。

```zsh
make setup
```

### 文書のビルド

普通、先に`make setup`が正常に完了していれば文書のみが生成されますが、`make setup`に失敗して`.image-built` ファイルがない場合、再度イメージを作成します。

 
```zsh
make all
```

普通、先に`make setup`が正常に完了していれば文書のみが生成されますが、`make setup`に失敗して`.image-built` ファイルがない場合、再度イメージを作成します。

LaTeX文書は、`src/` 以下に置いてください。Makefile中の `MAIN_FILE`でビルド対象の`.tex`ファイルが指定されます。


### 文書の校正
このプロジェクトには [textlint](https://textlint.github.io/) による自動校正用の設定が実装されています。

以下のようにして自動構成によるエラー指摘が得られます:

```zsh
% make test
```

また、一部の問題は以下のようにすることで自動修正されます。

```
make format
```

### Cleanup

生成ファイルは、以下のコマンドでcleanupできます。

```zsh
make clean
```

## VSCode Support
本プロジェクトは、Requirementsに挙げたプログラム以外に、エディタとしてVSCodeを使用することを想定して、[LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)などの拡張機能を設定してあります。適宜使用してください。


## CI workflow
また、本プロジェクトにはGitHub ActionsによるCI機能が設定されています。 [reviewdog](https://github.com/reviewdog/reviewdog)が、プルリクエストに含まれた校正上のエラーを検知し指摘します。


## そのほかの技術的詳細
### Docker Imageについて

このプロジェクトでは、[TeX Live](https://www.tug.org/texlive/) をUbuntu上でホストするdockerコンテナを利用します。
コンテナは 

```zsh
make image
```

でビルドされ、その名前は `yuseiito/texlive-ubuntu` です。
GitHub Container Registry上でもビルド済みコンテナを提供しています。以下のように入手できます。

```zsh
docker pull ghcr.io/yuseiito/texlive-ubuntu:latest
```

## Licence
このテンプレートのうち、このテンプレートリポジトリに格納されたデータはCC0ライセンスで配布します。(ただし、このリポジトリが読み込む各コンポーネントはそれぞれ別のライセンスで保護されている場合があります)

このテンプレートを用いて文書を公開される場合は、`LICENCE` ファイルおよび本ファイル下部のライセンスに関する記述を削除するか置き換えて、ご自身の文書の権利をご自身の責任で保護してください。
