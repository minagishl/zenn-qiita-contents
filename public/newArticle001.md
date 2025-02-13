---
title: Hono + Cloudflare Workers で REST API を作ろう！超入門
tags:
  - CloudflareWorkers
  - Hono
private: false
updated_at: "2025-02-02T02:53:29+09:00"
id: a31090c61b278ac08c10
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

この記事では Hono と Cloudflare Workers を使って REST API を作成する方法を紹介します。

## Hono とは

Hono は Cloudflare Workers / Pages だけではなく様々な環境で利用できる JavaScript / TypeScript のフレームワークです。

詳しくは様々な記事があるので省かさせていただきます。

## プロジェクトの作成・準備

Hono のテンプレートの中から cloudflare-workers テンプレートを選んでプロジェクトを新規作成します。

```shell-session
$ npm create hono@latest

create-hono version 0.6.3
? Target directory .
? Which template do you want to use? cloudflare-workers
✔ Cloning the template
? Do you want to install project dependencies? yes
? Which package manager do you want to use? npm
✔ Installing project dependencies
🎉 Copied project files
Get started with: cd .
```

次に Wrangler にログインしましょう。
Wrangler は Cloudflare Workers の CLI ツールです。

```shell-session
$ npx wrangler login

 ⛅️ wrangler 3.50.0
-------------------
Attempting to login via OAuth...
Opening a link in your default browser: https://dash.cloudflare.com/oauth2/auth
Successfully logged in.
```

## 起動

プロジェクトのディレクトリに移動して、以下のコマンドを実行します。

```shell-session
$ npm run dev
```

`http://localhost:8787` にアクセスすると、`Hello Hono!` と表示されるはずです。

## REST API の作成

`src/index.ts` を以下のように編集します。

```typescript
import { Hono } from "hono";

const app = new Hono();

app.get("/", (c) => {
  return c.text("Hello Hono!");
});

// Add a new route
app.get("/api", (c) => {
  return c.json({ message: "Hello Hono!" });
});

// Add a new route with a parameter
app.get("/api/hello/:name", (c) => {
  const name = c.params.name;
  return c.text(`Hello, ${name}!`);
});

export default app;
```

`/api` にアクセスすると JSON データが返ってくるようになりました。

`/api/hello/:name` にアクセスすると、`:name` に指定した名前が表示されるようになります。

## デプロイ

以下のコマンドでデプロイします。

```shell-session
$ npm run deploy

> deploy
> wrangler deploy --minify src/index.ts

 ⛅️ wrangler 3.50.0
-------------------
✔ Select an account › Your Account
Total Upload: 19.15 KiB / gzip: 7.27 KiB
Uploaded hono-introduction (1.14 sec)
Published hono-introduction (5.03 sec)
  https://hono-introduction.your-account.workers.dev
Current Deployment ID: 00000000-0000-0000-0000-000000000000
```

デプロイが完了すると URL が表示されるので、アクセスしてみましょう。

## まとめ

Hono と Cloudflare Workers を使って REST API を作成する方法を紹介しました。

詳しくは公式ドキュメントを参照してください。

- [Hono](https://hono.dev/)
- [Cloudflare Workers](https://workers.cloudflare.com/)
