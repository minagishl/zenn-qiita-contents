---
title: 初心者でも分かる Git の基本操作を 10 分でマスターする方法！
tags:
  - Git
  - GitHub
  - 初心者
  - 初心者向け
private: false
updated_at: '2025-02-02T02:53:29+09:00'
id: c1a7bb58232015960254
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

Git はプログラミングやプロジェクト管理において、コードやファイルのバージョン管理を行うための強力なツールです  
本記事では、初心者でも理解しやすいように、基本的な Git 操作をわかりやすく解説します

**この記事は 10 分程度で読める内容にまとめており、Git を使い始めるための最小限の知識を身につけることができます**  
**忙しい方やとりあえず Git を触ってみたい方にぴったりです！**

## 1. Git とは？

Git は、ファイルの変更履歴を管理するための「分散型バージョン管理システム」です  
これにより、過去のバージョンに戻したり、複数人で同じプロジェクトを効率的に進めることができます

## 2. Git を始める準備

まずは、Git をインストールしてセットアップを行います

1. **Git のインストール**

   - [Git 公式サイト](https://git-scm.com/downloads)からインストーラーをダウンロードしてインストールします

詳しくは次の記事が参考になります

https://kinsta.com/jp/knowledgebase/install-git/

2. **ユーザー情報の設定**
   Git を使う前に、名前とメールアドレスを設定します

   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

## 3. Git の基本操作

以下に、よく使う基本的な Git コマンドを紹介します

### 3.1 リポジトリの作成

Git で管理するプロジェクトを開始するには、リポジトリを作成します

```bash
mkdir my-project
cd my-project
git init
```

- `mkdir` はディレクトリを作成するコマンドです
- `git init` で Git リポジトリを初期化します

### 3.2 ファイルを追加してコミットする

Git では、ファイルをリポジトリに追加して「コミット」することで履歴を残します

1. 新しいファイルを作成する
   ```bash
   echo "Hello, Git!" > README.md
   ```
2. ファイルをステージングエリアに追加する
   ```bash
   git add README.md
   ```
3. ファイルをコミットする
   ```bash
   git commit -m "first commit"
   ```

### 3.3 状態を確認する

現在のリポジトリの状態を確認するには、以下のコマンドを使用します

```bash
git status
```

### 3.4 履歴を確認する

コミット履歴を確認するには以下のコマンドを使います

```bash
git log
```

## 4. GitHub との連携

GitHub は、Git リポジトリをオンラインで管理するためのサービスです  
以下は、ローカルリポジトリを GitHub にプッシュする方法です

1. **リモートリポジトリを追加する**

   ```bash
   git remote add origin https://github.com/your-username/my-project.git
   ```

2. **変更をプッシュする**

   ```bash
   git push -u origin main
   ```

## 5. よくある質問

### Q: 間違えて GitHub に Push してしまいました、どうすれば取り消せますか？

A: 以下の手順で、間違えた Push を取り消すことができます

1. リモートリポジトリの最新状態を確認する

   ```bash
   git fetch origin
   ```

2. 直前の Push を取り消す（履歴を残す場合）

   ```bash
   git reset --soft HEAD~1
   git push --force
   ```

   注意: この操作は他のコラボレーターに影響を与える可能性があるため、慎重に行ってください

3. または、新しい修正を追加して Push する

   ```bash
   git commit --amend
   git push --force
   ```

### Q: ファイルを間違えて削除してしまいました、どうすれば元に戻せますか？

A: Git は変更履歴を管理しているため、`git checkout` や `git restore` コマンドを使って以前の状態に戻せます

### Q: ステージングエリアに追加した変更を取り消すには？

A: 以下のコマンドを使います

```bash
git reset HEAD <file>
```

## まとめ

この記事では、Git の基本操作を 10 分で理解するために必要な知識を紹介しました  
ここで学んだ内容をもとに、実際に Git を使ってプロジェクトを管理してみましょう！

もっと詳しく学びたい方は、公式ドキュメントやオンラインチュートリアルもぜひチェックしてみてください
