---
title: New Relic を利用したアプリケーションとサーバーの監視
tags:
  - AdventCalendar
  - NewRelic
  - monitoring
  - AdventCalendar2024
private: false
updated_at: '2024-12-15T00:22:09+09:00'
id: 8fe3a0a2d8a1c7e0e46f
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに

この記事は、[New Relic 使ってみた情報をシェアしよう！ ](https://qiita.com/advent-calendar/2024/newrelic) 15 日目の記事です

本日は私の誕生日であり、大切な記念日に合わせて 15 日目の記事を担当させていただきました  
普段から愛用している New Relic について、その魅力を皆様と共有できることを大変嬉しく思います

本記事は Ubuntu 22.04 (Jammy Jellyfish) を基に執筆されています

現代のソフトウェア開発において、アプリケーションやサーバーのパフォーマンス監視は非常に重要です  
本記事では、New Relic を活用して効率的にアプリケーションとサーバーを監視する方法について解説します

## New Relic とは？

New Relic は、アプリケーションパフォーマンス監視 (APM) やサーバー監視、ログ管理など、多岐にわたる機能を提供する統合プラットフォームです  
これにより、エラーの特定、パフォーマンスの向上、ユーザーエクスペリエンスの最適化が可能になります

## New Relic の主要機能

1. **APM（アプリケーションパフォーマンス監視）**

   - アプリケーションのトランザクションを可視化し、ボトルネックを特定します
   - リアルタイムでのパフォーマンスメトリクスの収集

2. **インフラストラクチャ監視**

   - CPU、メモリ、ディスク使用率などのシステムリソースを監視
   - サーバーの状態をリアルタイムで把握

3. **分散トレーシング**

   - マイクロサービス間の依存関係を可視化
   - 問題の発生源を迅速に特定可能

4. **ログ管理**

   - アプリケーションやサーバーからのログを統合的に管理
   - エラーログや警告のトラッキング

5. **アラートとダッシュボード**

   - カスタマイズ可能なダッシュボードでデータを可視化
   - 異常を即座に検知し、通知を設定可能

## アプリケーションに導入する

### 1. アカウント作成

公式サイト ([https://newrelic.com/](https://newrelic.com/)) にアクセスし、無料アカウントを作成します

無料アカウントでは以下のことが可能です

- アプリケーションの基本的なパフォーマンス監視 (APM) を使用してトランザクションデータを確認
- サーバーのインフラストラクチャ監視でリソース使用状況をリアルタイムで把握
- ログ管理の基本機能を活用
- Synthetics を使ってウェブサイトや API の監視

初心者でも気軽に試せるので、ぜひ登録してみてください！

> **注意:** アカウント作成時には、GitHub などの外部サービスを使用せずにメールアドレスで登録することを推奨します  
> 一部の機能、特にアラートのワークフロー編集において、エラーが発生する可能性があります（詳細: [関連フォーラム記事](https://forum.newrelic.com/s/hubtopic/aAXPh0000006yhROAQ/issue-trying-to-edit-workflows)）

### 2. エージェントのインストール

- **Node.js アプリケーションでの New Relic エージェントの導入**

  1. New Relic Node.js エージェントをインストールします

     ```bash
     npm install newrelic --save
     ```

  2. プロジェクトのルートディレクトリに `newrelic.js` ファイルを作成します

     ```bash
     cp ./node_modules/newrelic/newrelic.js ./newrelic.js
     ```

  3. `newrelic.js` ファイル内でライセンスキーを設定します

     ```javascript
     exports.config = {
       app_name: ["Your Application Name"],
       license_key: "YOUR_NEW_RELIC_LICENSE_KEY",
       logging: {
         level: "info",
       },
     };
     ```

     環境変数を指定してライセンスキーを設定することも可能です（詳細: [公式ドキュメント](https://docs.newrelic.com/jp/docs/apm/agents/nodejs-agent/installation-configuration/install-nodejs-agent/#installing)）

  4. アプリケーションを実行し、New Relic ダッシュボードでデータを確認します

     ```bash
     node -r newrelic index.js
     ```

  サンプルコード（`index.js` として保存）

  ```javascript
  const express = require("express");
  const app = express();

  app.get("/", (req, res) => {
    res.send("Hello, New Relic!");
  });

  app.get("/health", (req, res) => {
    res.status(200).send({ status: "OK" });
  });

  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
  ```

## サーバーに導入する

### New Relic Infrastructure Agent のインストール手順

詳細な手順については、公式ドキュメント [New Relic Infrastructure Agent のインストール](https://docs.newrelic.com/jp/docs/infrastructure/infrastructure-agent/linux-installation/package-manager-install/) を参照してください

1. **対応する OS の確認**

   - 自分のデバイスがどの OS を使用しているか確認するには、以下のコマンドを使用してください
     ```bash
     cat /etc/lsb-release
     ```
   - このコマンドにより、デバイスの OS 情報が表示されます  
     表示された情報をもとに次の手順を進めてください
   - New Relic Infrastructure Agent は主要な Linux ディストリビューション (Ubuntu, CentOS, Red Hat) に対応しています

2. **リポジトリの設定**

   - **Ubuntu/Debian**
     ```bash
     curl -fsSL https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/newrelic-infra.gpg
     echo "deb https://download.newrelic.com/infrastructure_agent/linux/apt/ jammy main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list
     sudo apt-get update
     ```
     > **注意:** お使いのデバイスの OS バージョンに応じて `jammy` を適切なバージョン名（例: `focal`, `bionic` など）に書き換えてください
   - **CentOS/Red Hat**
     ```bash
     sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
     sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
     ```

3. **エージェントのインストール**

   - **Ubuntu/Debian**
     ```bash
     sudo apt-get install newrelic-infra -y
     ```
   - **CentOS/Red Hat**
     ```bash
     sudo yum install newrelic-infra -y
     ```

4. **エージェントの設定ファイル編集**

   - `/etc/newrelic-infra.yml` を編集し、ライセンスキーを設定します
     ```yaml
     license_key: YOUR_NEW_RELIC_LICENSE_KEY
     ```

5. **サービスの起動と確認**

   ```bash
   sudo systemctl start newrelic-infra
   sudo systemctl enable newrelic-infra
   systemctl status newrelic-infra
   ```

   - サービスが正常に起動しているかを確認します

6. **ダッシュボードの確認**

   - New Relic Web UI にログインし、インフラストラクチャタブでサーバーのデータが表示されていることを確認します

#### 設定とカスタマイズ

- メトリクス収集の閾値や、アラートルールを設定します
- チームメンバーとダッシュボードを共有し、必要な情報を全員が把握できるようにします

## New Relic Synthetics の活用例

New Relic Synthetics を利用することで、Web アプリケーションや API の稼働状況を監視することができます  
Synthetics を活用することで、ユーザーエクスペリエンスの向上や障害の早期発見に役立ちます

### Synthetic モニターの作成手順

1. **New Relic Web UI にログイン**

   - 左側のナビゲーションメニューから「Synthetic Monitoring」を選択します
   - 「Create your first monitor」をクリックします<details><summary>スクリーンショット</summary>
   ![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/11cf8280-58e8-b140-b7a9-79637540f307.png)
   </details>

2. **モニターの種類を選択**

- 「Availability」や「User flow / functionality」、「Endpoint availability」など、目的に応じて選択します

3. **モニターの設定**

   - URL: 監視対象の URL を入力します
   - 頻度: モニターを実行する間隔を設定します<details><summary>スクリーンショット</summary>
   ![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/7230b95d-9143-ec10-55bf-52b17f89a478.png)
   </details>

4. **地域を選択**

   - モニターを実行する地域を選択します

5. **保存と実行**

   - 設定を保存し、モニターを開始します

## 実用例

1. **アプリケーションのボトルネックの特定**

   - 特定の API コールが遅い場合、その詳細な情報をトレースして原因を特定します

2. **ユーザーエクスペリエンスの向上**

   - ページロード時間を監視し、最適化の施策を講じることで、ユーザーエクスペリエンスを向上させます

## New Relic アラートの設定例

New Relic のアラートを設定することで、システムの異常を迅速に検知し、対応することが可能です  
以下はアラートポリシーの設定例です

### アラートポリシーの作成

1. **New Relic Web UI にログイン**

   - 左側のナビゲーションメニューから「Alerts」を選択します
   - 「Alert Policies」をクリックし、「Create a policy」を選択します<details><summary>スクリーンショット</summary>
   ![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/492631fd-c63d-8cea-e739-9b81418ba541.png)
   </details>

2. **通知チャネルの設定**

   - モバイルアプリを利用して通知を受け取ることも可能です  
      詳細については、公式ドキュメント [New Relic モバイルアプリ](https://docs.newrelic.com/jp/docs/mobile-apps/mobile-apps-intro/) をご覧ください
   - 例: Slack、Webhook またはメールを選択します<details><summary>スクリーンショット</summary>
   ![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/7b9f3011-2ceb-7085-8d45-e3e7a5953998.png)
   </details>

3. **アラート条件の設定**

   - 新しい条件を追加します。「New alert condition」をクリックし、監視したい対象を選択します
   - 例: CPU 使用率が 80% を超えた場合、またはレスポンス時間が 2 秒以上になった場合など

4. **保存と有効化**

   - 設定を保存して、アラートポリシーを有効化します

### アラートの実例

以下は、Node.js アプリケーションのレスポンス時間を監視するアラートの例です

- **条件**
  - トランザクションの平均レスポンス時間が 2 秒を超えた場合
- **通知**
  - Slack に通知を送信

## おすすめの設定と活用方法

- **カスタムダッシュボード**

  - チームやプロジェクトに合わせて重要なメトリクスを表示するダッシュボードを作成します
  - ダッシュボードを共有することで、全員が同じ情報を把握できるようにします

- **アラートの活用**

  - 異常が発生した場合にすぐ対応できるよう、Slack やメールで通知を受け取る設定を行います

- **統合**
  - 他のツール（JIRA、Slack、Instatus、Better Stack など）と連携して、運用プロセスを効率化します
  - 例: エラーが発生した場合に自動的にチケットを作成する

## まとめ

New Relic は、アプリケーションやサーバーの監視を効率化し、開発や運用の質を向上させる強力なツールです
本記事で紹介した方法を参考に、ぜひ導入を検討してみてください
