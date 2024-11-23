---
title: Hono + Cloudflare で Twemoji を返却するAPIを作成した！
tags:
  - twemoji
  - CloudflarePages
  - Hono
private: false
updated_at: '2024-11-24T02:18:44+09:00'
id: f03f0752edbaca15b604
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

今回は、Hono、Cloudflare Pages を使って、簡単に Twemoji を返却する API を作ってみた話をまとめました！

この記事では、その作成過程や使った技術について紹介します
なお、Hono などの詳細な解説は省略しますので、詳しく知りたい方は公式ドキュメントを参照してください

このプロジェクトは以前の記事で作成した [Hono + Satori + Cloudflare でアバター生成 API を作った！](https://qiita.com/minagishl/items/0874a71924ae6526abdf) をベースに、Twemoji を返却する API を作成しました

## プロジェクトの概要

このプロジェクトでは、ユーザーが指定した絵文字をもとに、Twemoji を返却する API を作りました
どんな技術を使って、どうやって実現したのかを紹介します

### 1. Hono で API ポイントを作成

Hono は非常に軽量で高速なウェブフレームワークです
このプロジェクトでは、API のエンドポイントを作成し、ユーザーが入力した絵文字を受け取り、変数に格納しました

（今回は以前のコードよりも綺麗に描けたと思います）

https://github.com/minagishl/hono-twemoji/blob/a0da4d534900bd84f0b1d5a7492b173798419d52/src/index.ts#L48-L80

### 2. 独自関数で ID に変換

個人的には、絵文字を ID に変換する関数が一番難しかったです
絵文字を ID に変換するために、絵文字の Unicode を取得し、それを元に ID を生成しました

https://github.com/minagishl/hono-twemoji/blob/a0da4d534900bd84f0b1d5a7492b173798419d52/src/index.ts#L6-L42

### 3. Cloudflare Pages にデプロイ

Cloudflare Pages は、静的サイトや Next.js などを簡単にデプロイできるサービスです。このプロジェクトでは、Cloudflare Pages を使って、Twemoji を返却する API をデプロイしました

個人的に Cloudflare Workers よりも Pages の方が `{appname}.{username}.workers.dev` という URL が `{appname}.pages.dev` になるので、敷居が低いと感じています

### 4. 使い方

この API は、以下の URL にアクセスすることで利用できます

```
https://hono-twemoji.pages.dev/emoji/👍.png
```

## まとめ

今回は Hono、Cloudflare Pages を使って、Twemoji を返却する API を作成しました
興味がある方は、ぜひ [GitHub のリポジトリ](https://github.com/minagishl/hono-twemoji) をご覧ください

またもしよろしければ、以前の記事もご覧いただけると幸いです

https://qiita.com/minagishl/items/0874a71924ae6526abdf

コードに関するレビューやフィードバックがあれば、大歓迎です！どんな意見でもお待ちしています
