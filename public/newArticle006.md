---
title: Astro を利用して個人ブログを作成する方法
tags:
  - AdventCalendar
  - astro
  - AdventCalendar2024
private: false
updated_at: "2025-02-02T02:53:29+09:00"
id: 9984b4a41f153abc3126
organization_url_name: null
slide: false
ignorePublish: false
---

この記事は、[はじめてのアドベントカレンダー](https://qiita.com/advent-calendar/2024/first-time) 5 日目の記事です

初めてアドベントカレンダーに参加したので少し緊張していますが、自分が描ける範囲で記事を書いていきたいと思います

## はじめに

数日前に Astro を利用して個人ブログを作成したのですがその際の体験がとても良かったので、Astro を利用して個人ブログを作成する方法を紹介します

## Astro とは

Astro は、静的サイトジェネレーターの一つで、コンテンツを高速かつ効率的に配信するために設計されています  
Astro は、JavaScript フレームワークやライブラリ（React、Vue、Svelte など）と統合できる柔軟性を持ち、開発者が好みのツールを使用してコンポーネントを作成できます

### 特徴

- **パフォーマンス**: Astro は、必要な部分だけをクライアントに配信するため、ページの読み込み速度が非常に速いです
- **柔軟性**: React、Vue、Svelte など、さまざまなフレームワークと統合することができます
- **拡張性**: プラグインやテーマを利用して、機能を簡単に拡張できます

## Astro をセットアップする

Astro を利用して個人ブログを作成するためには、まず Astro をセットアップする必要があります  
次のコマンドを実行して、Astro プロジェクトを作成します

```shell
npm create astro@latest -- --template blog
```

質問に従ってプロジェクトを作成し、次のコマンドを実行して開発サーバーを起動します

```shell
npm run dev
```

ブラウザで `http://localhost:4321` にアクセスすると、Astro のデフォルトのブログテンプレートが表示されます

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/bca8016c-cb0b-a8c8-3345-e842b11018e8.png)

## ブログ記事を追加する

Astro のデフォルトのブログテンプレートには、`src/content/blog` ディレクトリが含まれており、このディレクトリにブログ記事を追加することができます

`src/content/blog` ディレクトリに、新しい Markdown ファイル（例: `hello.md`）を作成し、記事の内容を記述します

```markdown
---
title: "Hello Astro!"
description: "This is the first Astro article I've created!"
pubDate: "Dec 05 2024"
heroImage: "/blog-placeholder-5.jpg"
---

Hello, Astro! This is the first Astro article I've created!
```

このように、`title`、`description`、`pubDate`、`heroImage` などのフロントマターを設定し、記事の内容を記述します

ブラウザで `http://localhost:4321/blog/hello` にアクセスすると、新しいブログ記事が表示されます

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/b2a7cb6e-52f6-4d3f-11d8-b2baf71f6ddf.png)

## ソーシャルメディアの埋め込み

Astro では、ソーシャルメディアの埋め込みも簡単に行うことができます
コマンドを利用して次のパッケージをインストールします

```shell
npm i astro-embed
```

先ほど作成した `hello.md` の名前を `hello.mdx` に変更し、次のようにソーシャルメディアの埋め込みを追加します

```markdown
---
title: "Hello Astro!"
description: "This is the first Astro article I've created!"
pubDate: "Dec 05 2024"
heroImage: "/blog-placeholder-5.jpg"
---

<!-- Omit code as it will be off the screen. -->

import { BlueskyPost } from 'astro-embed';

<BlueskyPost id='https://bsky.app/profile/mk.gg/post/3la4wqeyztm2u' />
```

このように、`astro-embed` パッケージをインポートし、`<BlueskyPost id='' />` のように埋め込みたいソーシャルメディアのコンポーネントを追加します

ブラウザで `http://localhost:4321/blog/hello` にアクセスすると、ソーシャルメディアの埋め込みが表示されます

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/9948669c-7b12-7a99-be91-aab0b689c5cc.png)

## まとめ

Astro を利用して個人ブログを作成する方法を紹介しました
Astro は、パフォーマンスが高く、柔軟性があり、拡張性があるため、個人ブログを作成するのに最適なツールです
ぜひ、Astro を利用して個人ブログを作成してみてください！
