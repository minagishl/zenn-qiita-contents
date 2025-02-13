---
title: Discord サーバーを守る ロール認証アプリを作成した話
tags:
  - discord
  - CloudflareWorkers
  - Hono
private: false
updated_at: "2025-02-02T03:02:44+09:00"
id: deee4bfdb34c91874775
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

私は通信高校に通っており、同好会の運営を行っています
しかし、昨日サーバーの招待リンクが学園外に漏れてしまい、第三者が不正に参加する事態が発生しました
この問題を解決するために、特定のメールアドレスを持つユーザーだけがサーバーに参加できるようにする認証機能を実装しました

本記事では、このアプリケーションの実装内容や、開発において工夫した点を紹介します

## アプリの概要

このアプリは、Cloudflare Workers と Hono を使用して、Discord サーバーのメンバーに特定のロールを付与する仕組みを提供します
認証には Discord OAuth2 と Google OAuth2 を利用し、指定したメールアドレスのドメインを持つユーザーのみが認証を通過できるようにしています

### 主な機能

- Discord OAuth2 を利用したユーザー認証
- Google OAuth2 でメールアドレスを取得し、ドメインをチェック
- 許可されたメールアドレスのユーザーに対して Discord の特定のロールを付与
- JWT と CSRF 対策を施し、セキュリティを強化

## 実装で頑張った部分

### 1. CSRF 対策

OAuth2 の `state` パラメータを利用し、CSRF 攻撃を防ぐ仕組みを実装しました
具体的には、認証開始時にランダムな `state` 値を生成し、クッキーに保存しておき
認証後に返ってきた `state` 値と照合し、一致しない場合は認証を拒否するようにしました
[index.ts (Lines 21 to 36 in 9e3c108)](https://github.com/minagishl/discord-email-auth/blob/9e3c1084053218d76aacd9b596fd9ddd0ef4dda1/src/index.ts#L21-L36)

```ts
// Function to generate state for CSRF protection
async function generateState(): Promise<string> {
  const buffer = new Uint8Array(32);
  crypto.getRandomValues(buffer);
  const state = Array.from(buffer)
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
  return state;
}

// Validate the CSRF token
function validateState(c: Context, state: string): boolean {
  const savedState = getCookie(c, "oauth_state");
  deleteCookie(c, "oauth_state");
  return savedState === state;
}
```

### 2. JWT によるセッション管理

Discord ユーザー ID を安全に保存するため、JWT を使用しました
JWT の署名には環境変数 `JWT_SECRET` を用いることで、安全性を確保しています
[index.ts (Lines 118 to 125 in 9e3c108)](https://github.com/minagishl/discord-email-auth/blob/9e3c1084053218d76aacd9b596fd9ddd0ef4dda1/src/index.ts#L118-L125)

```ts
// Save discordUserId safely with JWT
const jwt = await sign({ discordUserId }, c.env.JWT_SECRET);
setCookie(c, "discord_user", jwt, {
  httpOnly: true,
  secure: true,
  sameSite: "Lax",
  maxAge: 600,
});
```

### 3. メールドメインのチェック

Google OAuth2 を使用して取得したメールアドレスのドメインをチェックし、特定のドメインを持つユーザーのみを許可します
[index.ts (Lines 212 to 216 in 9e3c108)](https://github.com/minagishl/discord-email-auth/blob/9e3c1084053218d76aacd9b596fd9ddd0ef4dda1/src/index.ts#L212-L216)

```ts
const allowedDomains = ["nnn.ed.jp", "n-jr.jp", "nnn.ac.jp"];
const emailDomain = email.split("@")[1];
if (!allowedDomains.includes(emailDomain)) {
  return c.json({ error: "Email domain not allowed" }, 403);
}
```

### 4. Discord ロールの付与

認証を通過したユーザーには、Discord の API を用いて特定のロールを付与します
[index.ts (Lines 245 to 255 in 9e3c108)](https://github.com/minagishl/discord-email-auth/blob/9e3c1084053218d76aacd9b596fd9ddd0ef4dda1/src/index.ts#L245-L255)

```ts
// Assign a role
const roleResponse = await fetch(
  `${c.env.DISCORD_API_BASE}/guilds/${c.env.DISCORD_GUILD_ID}/members/${discordUserId}/roles/${c.env.DISCORD_ROLE_ID}`,
  {
    method: "PUT",
    headers: {
      Authorization: `Bot ${c.env.DISCORD_BOT_TOKEN}`,
      "Content-Type": "application/json",
    },
  },
);
```

## まとめ

今回、Discord サーバーの安全性を向上させるために、ロール認証システムを実装しました
私にとって初めての JWT や CSRF 対策の実装でしたが、セキュリティの重要性を実感しながら学ぶ良い機会となりました
今後もより安全で使いやすい仕組みを考え、改善を続けていきたいと思います
