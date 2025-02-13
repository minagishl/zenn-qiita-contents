---
title: Hono + Satori + Cloudflare でアバター生成 API を作った！
tags:
  - satori
  - CloudflarePages
  - Hono
private: false
updated_at: "2024-07-27T13:47:10+09:00"
id: 0874a71924ae6526abdf
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

今回は、Hono、Satori、Cloudflare Pages を使って、簡単に文字や背景色を指定してアバターを作れる API を作ってみた話をまとめました！

この記事では、その作成過程や使った技術について紹介します
なお、Hono などの詳細な解説は省略しますので、詳しく知りたい方は公式ドキュメントを参照してください

## プロジェクトの概要

このプロジェクトでは、ユーザーが指定した文字やアイコンをもとに、アバター画像を生成する API を作りました。どんな技術を使って、どうやって実現したのかを紹介します

### 1. Hono で API ポイントを作成

Hono は非常に軽量で高速なウェブフレームワークです
このプロジェクトでは、API のエンドポイントを作成し、ユーザーが入力した文字や背景色を受け取り、変数に格納しました

（見る人によっては少しひどいコードかもしれませんが、ご容赦ください）

https://github.com/minagishl/hono-avatars/blob/052091db937681936bb02733363e10c372a42acf/src/index.ts#L60-L115

### 2. Satori でアバター画像を生成

Satori は画像生成用のライブラリです
このプロジェクトでは、Satori を使ってユーザー指定の文字や背景色からアバター画像を生成しました。Satori はカスタマイズがしやすく、簡単な画像の生成から複雑な画像の生成まで幅広く対応しています

また、JSX を使ってアバター画像を生成するコードを書くことができます
これにより、作業時間が大幅に短縮しました！

https://github.com/minagishl/hono-avatars/blob/052091db937681936bb02733363e10c372a42acf/src/image.tsx#L5-L35

実はここで少しつまずいてしまって、`.wasm` ファイルを esbuild でビルドする方法がわからず、悪魔的な方法で解決しました
もしもっと良い方法があれば教えてください

### 3. Cloudflare Pages にデプロイ

Cloudflare Pages は、静的サイトや Next.js などを簡単にデプロイできるサービスです。このプロジェクトでは、Cloudflare Pages を使って、アバター生成 API をデプロイしました

詳しくは省きますが、GitHub にリポジトリを Push するだけでデプロイできるので、非常に便利です

### 4. Ui Avatars との互換性

このプロジェクトで作成した API は、既存の ui-avatars.com と互換性があります
つまり、ui-avatars.com で使用している URL パラメータをそのまま使って、同様の機能を提供することができます。これにより、ui-avatars.com を利用していたシステムに対してもスムーズな移行が可能です

## 使い方

この API は、以下の URL にアクセスすることで利用できます

```
https://hono-avatars.pages.dev/?name=john+doe
```

`name` パラメータには、アバターに表示する文字列を指定します
また、`background` パラメータには、背景色を指定することができます

```
https://hono-avatars.pages.dev/?background=0D8ABC&color=fff
```

詳しくは、[GitHub の README](https://github.com/minagishl/hono-avatars/#readme) を参照してください

ですが、まだまだ機能が足りない部分もあるので、今後の改善に期待してください！

## まとめ

Hono、Satori、Cloudflare Pages を使って、簡単に文字や背景色を指定してアバターを生成できる API を作成しました。興味がある方は、ぜひ [GitHub のリポジトリ](https://github.com/minagishl/hono-avatars) をチェックしてみてください！

コードに関するレビューやフィードバックがあれば、大歓迎です！どんな意見でもお待ちしています
