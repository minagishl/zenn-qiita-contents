---
title: Markdown AI を利用して要約機能付きのニュースサイトを作成する！
tags:
  - AdventCalendar
  - AdventCalendar2024
  - MarkdownAI
private: false
updated_at: '2024-12-10T00:00:22+09:00'
id: f707fa496117f396cad0
organization_url_name: null
slide: false
ignorePublish: false
---
この記事は、[Markdown AI のサーバー AI 機能を使って Web サイトを作ってみよう](https://qiita.com/advent-calendar/2024/markdownai) 10 日目の記事です

最近は忙しくてニュースを見る時間がない…という方も多いのではないでしょうか？  
そんな方におすすめなのが、要約機能付きのニュースサイトです

この記事では、Markdown AI を利用して要約機能付きのニュースサイトを作成する方法を紹介します

## はじめに

最近は、情報が爆発的に増えており、ニュースを見る時間がないという方も多いのではないでしょうか？  
そんな方におすすめなのが、要約機能付きのニュースサイトです

要約機能付きのニュースサイトを作成することで、短時間で多くの情報をキャッチアップすることができます

## Markdown AI とは

Markdown AI は、Markdown 記法を用いて簡単に Web サイトや資料を作成・公開できるサービスです  
プログラミングやサーバー設定の知識がなくても、直感的な操作でコンテンツを作成し、即座に公開することが可能です

さらに、Markdown AI では、サイト内に AI 機能を組み込むことも容易です  
ユーザーは提供されている AI モデルから選択し、プロンプトを設定することで、独自の AI をサイトに導入できます  
これにより、サイト内でのチャットボットの設置や、特定のサービスに特化した AI の活用が可能となります

## 実際に作成してみる

詳しくは「[MarkdownAI の誰でもわかる使い方](https://qiita.com/mdown_ai_jpn/items/d3e281565c876a0bd64f)」を参照してください

### 1. サインアップする

まずは、Markdown AI のサイトにアクセスし、Googel のアカウントを連携し、アカウントを作成します  
ボタン一つでサインアップが完了します

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/ac6d8b98-11b0-3738-6492-d9bd71610780.png)

### 2. 新規プロジェクトを作成する

サインアップ後、左側ダッシュボードの「＋」ボタンを押して、新しくプロジェクトを作成します  
プロジェクト名は自由に決められ、例えば「料理ブログ」や「ゲーム日記」など、興味のあるテーマで始めると良いでしょう。

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/64f3ec60-deda-7666-095e-62fd351e3bc4.png)

### 3. コンテンツを作成する

簡単な文章を Markdown 記法で記述し、プレビューを確認しながらコンテンツを作成します

```markdown
# 本日のニュース

- 〇〇社が新製品を発表
- 半導体不足が深刻化
```

次に「Save」ボタンを押して、コンテンツを保存してから「View」ボタンを押して、コンテンツをプレビューします

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/3601f742-69d5-773c-56a6-7a1067b7b76b.png)

> 公開する場合は「URL」ボタンを押して、「Publish」ボタンを押すことで、公開することができます  
> 例: https://mdown.ai/content/3b54a17f-f054-42c2-8447-5aec38bc6df5

## AI を利用した要約機能を追加する

### 1. ロボットボタンを押す

ロボットボタンを押すと、AI 設定画面が表示されます

### 2. AI モデルを選択する

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/db845533-aec7-0ccb-aa53-8a88602e8d00.png)

- **Model List:** 今まで制作された AI モデルが表示されます
- **Select Model:** 使用する AI モデルを選択して下さい  
  　 **Model Name:** 作成する AI モデルの名前を入力して下さい

### 3. プロンプトを設定する

以下は、サンプルのプロンプトです

```markdown
以下の日本語の記事を読み、内容を簡潔に要約してください
要約は主要なポイントを含む 3〜5 文で構成してください
Markdown を利用せず、文章のみで要約してください
```

### 4. AI を作成する

今回は「Knowledge」は設定せずに「Create」ボタンを押して AI を作成して、保存します

## 記事に AI 要約機能を追加する

### 1. AI を記事に挿入する

画面上部にある、「Insert」ボタンを押して、画像を挿入するか、AI を挿入するか聞かれるので「Script」ボタンを押して、AI を挿入します

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/d38a4c88-f7e4-60bb-2018-4d798a350d3c.png)

正しく埋め込みができると次の様になります

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/32ced5dc-778f-2fec-b28a-f5e67fd1c6ff.png)

### 2. 要約機能を実装する

先ほど挿入されたスクリプトを次の様に書き換えます

```html
<div style="display: inline-block;">
  <button type="button" id="button-id">要約する</button>
</div>

<div id="answer-id"></div>

<script>
  (() => {
    const button = document.getElementById("button-id");
    button.addEventListener("click", async (event) => {
      button.disabled = true;

      // Class name text-preview Get the text of the element
      const textPreviewElement = document.querySelector(".text-preview");
      const message = textPreviewElement ? textPreviewElement.innerText : "";

      const serverAi = new ServerAI();
      const answer = await serverAi.getAnswerText("id", "", message);

      document.getElementById("answer-id").innerText = answer;
      button.disabled = false;
    });
  })();
</script>
```

`button-id` などは生成された ID に置き換えてください

最後に「Save」ボタンを押して、コンテンツを保存してから「View」ボタンを押して、コンテンツをプレビューします

### 3. 実際に動かしてみる！

正しく実装できていれば、次の様になります

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3480180/48fd1653-2df1-274d-724b-6d6259a8bd0a.png)

## まとめ

Markdown AI を利用して要約機能付きのニュースサイトを作成する方法を紹介しました

私個人の感想になりますが、AI を利用することで、短時間で多くの情報をキャッチアップすることができるため、非常に便利だと感じました  
また、ここにプラスで CSS を利用してデザインを工夫することで、より見やすいニュースサイトやブログなどを作成することができると思います

皆さんも是非、Markdown AI を利用して、要約機能付きのニュースサイトを作成してみてください！
