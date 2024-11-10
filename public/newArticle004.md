---
title: 【備忘録】Gmail でダークモードに対応させる方法
tags:
  - mail
  - 備忘録
private: false
updated_at: '2024-11-10T18:55:44+09:00'
id: 476150a8d00bfccee71b
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

Gmail のダークモードに対応したメールを作成する際のポイントをまとめました

## 対応方法

1. メールの HTML で `color-scheme` を指定します

```html
<html>
	<head>
		<meta name="color-scheme" content="light dark" />
		<meta name="supported-color-schemes" content="light dark" />
	</head>
	<body class="contents">
		<!-- メール本文 -->
	</body>
</html>
```

2. CSS でダークモード時のスタイルを定義

```css
@media (prefers-color-scheme: dark) {
	.contents {
		background-color: #1f1f1f;
		color: #ffffff;
	}
}
```

`@media` クエリを使って、ダークモード時のスタイルを指定します

3. ウェブ環境にも対応する

```css
[data-ogsc] .contents {
	background-color: #1f1f1f;
	color: #ffffff;
}
```

`[data-ogsc]` は、ウェブ環境において
`color-scheme` が効かない問題を解決するための CSS セレクタです

## 主な注意点

- `color-scheme` は、`<meta>` タグに指定する必要がある
- `color-scheme` は、`light` と `dark` の 2 つの値を指定する

## テスト方法

おすすめのツール

https://putsmail.com/

Putsmail は、HTML メールを簡単にテストできるツールです

## まとめ

Gmail のダークモードに対応したメールを作成する際は、`color-scheme` を指定して、ダークモード時のスタイルを `@media` と `[data-ogsc]` で定義することがポイントです
