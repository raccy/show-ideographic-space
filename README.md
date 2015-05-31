# Show Ideographic Space Package
This package show ideographic spaces ("　", U+3000, 和字間隔, known as FULLWIDTH SPACE).

## Change character, colors, etc
No config, only your stylesheet. By opening the "Open Your Stylesheet", you can change the content, the text color, and the background color as below. (see also `~/.atom/packages/show-ideographic-space/styles/show-ideographic-space.less`)

```styles.less
atom-text-editor, atom-text-editor::shadow {
  .highlight.ideographic-space {
    .region:after {
      color: #800000;
      content: '×';
      background-color: #CCCCCC;
    }
  }
}
```

# 和字間隔表示パッケージ
和字間隔("　"、U+3000、IDEOGRAPHIC SPACE、いわゆる全角スペース)を目に見える形で表示します。

## 文字や色の変更
設定では無くスタイルシートで指定します。フォントの色や背景色を変更したい場合は「Open Your Stylesheet」から個人設定のスタイルシートを開いて、下記のようにカスタマイズすることができます。 (参照 `~/.atom/packages/show-ideographic-space/styles/show-ideographic-space.less`)

```styles.less
atom-text-editor, atom-text-editor::shadow {
  .highlight.ideographic-space {
    .region:after {
      color: #800000;
      content: '×';
      background-color: #CCCCCC;
    }
  }
}
```

![A screenshot of show ideographic space package](http://raccy.github.io/images/trap-of-fullwidth-space.jpg)
