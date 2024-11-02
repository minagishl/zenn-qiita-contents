---
title: 私が作成した地震情報通知サービスの紹介
tags:
  - OSS
  - オープンソース
  - 地震
  - 分散型SNS
private: false
updated_at: '2024-11-02T11:54:07+09:00'
id: 5dc0560c5cd0ea5229eb
organization_url_name: evacuate
slide: false
ignorePublish: false
---

## はじめに

地震大国である日本において、迅速かつ信頼性の高い地震情報の共有は非常に重要です
本記事では、私が開発した、分散型 SNS や各種プラットフォームに地震情報を自動投稿するオープンソースプロジェクト「evacuate」を紹介します

https://github.com/evacuate/evacuate

## このサービスについて

「evacuate」は、リアルタイムで地震情報を取得し、指定されたサービスに自動的に投稿する TypeScript 製のアプリケーションです
分散型 SNS である Bluesky、Mastodon、Nostr に対応しており、特定のサーバーがダウンしても情報共有が継続されるという利点があります
また、個人用途として Webhook、Slack、Telegram にも対応しています

## 主な特徴

- **リアルタイムデータ取得**：WebSocket API を通じて地震データを受信し、即座に処理します
- **多様なプラットフォーム対応**：Bluesky、Mastodon、Nostr、Webhook、Slack、Telegram など、複数のプラットフォームに情報を投稿可能です
- **オープンソース**：GitHub 上で公開されており、誰でもコードを閲覧・貢献できます

## 安全性と運用コスト

「evacuate」は、New Relic を活用してサーバーとアプリケーションの監視を行っており、システムの安全性と信頼性を確保しています
また余談にはなりますが、XServer の 2GB プラン（月額約 1,150 円）で運用されており、コストパフォーマンスにも優れています

## ミニバージョンの提供

「evacuate」には、Discord に地震情報を投稿する軽量版も提供しています
こちらは、TypeScript で開発されたアプリケーションで、WebSocket API を通じて地震データを受信し、Discord の Webhook を使用して情報を投稿します
詳細はリポジトリをご覧ください

https://github.com/evacuate/micro

## コミュニティへの参加と貢献

「evacuate」はオープンソースプロジェクトであり、コミュニティからのフィードバックや貢献を歓迎しています
バグ報告や機能提案などがありましたら、GitHub の [Issues](https://github.com/evacuate/evacuate/issues) にてお知らせください
皆様のご協力が、より良いサービスの提供につながります！

## まとめ

「evacuate」は、分散型 SNS や各種プラットフォームに地震情報を自動投稿することで、情報共有の信頼性と迅速性を高めるツールです
オープンソースで開発されており、技術者の皆様の参加をお待ちしています
ぜひ、プロジェクトに貢献し、共に安全な情報共有環境を築きましょう
