# Show Ideographic Space Package
This package show ideographic spaces ("　", U+3000, 和字間隔, known as FULLWIDTH SPACE).

Need you to confirm a "Show Invisibles" setting. Only when it's true, your editor shows ideographic spaces.

This package hacks the Atom core with the nonstandard API. Please note that it may not operate when you update Atom.

## Change colors
By opening the "Open Your Stylesheet", you can change the text color and the background color as below.

```style.less
.editor, atom-text-editor::shadow {
  .ideographic-space {
    background-color: @background-color-warning;
  }
}
```

# 和字間隔表示パッケージ
和字間隔("　"、U+3000、IDEOGRAPHIC SPACE、いわゆる全角スペース)を目に見える形で表示します。

「Show Invisibles」の設定を確認してください。有効の時のみ、和字間隔は表示されます。

このパッケージは非標準のAPIを使用して、Atomコアをハックしています。バージョンアップにより動作しなくなる場合がありますので、ご注意ください。

## 色の変更
フォントの色や背景色を変更したい場合は「Open Your Stylesheet」から個人設定のスタイルシートを開いて、下記のようにカスタマイズすることができます。

```style.less
.editor, atom-text-editor::shadow {
  .ideographic-space {
    background-color: @background-color-warning;
  }
}
```

![A screenshot of show ideographic space package](http://raccy.github.io/images/trap-of-fullwidth-space.jpg)
