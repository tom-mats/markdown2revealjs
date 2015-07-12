# test

## slide

### background

* background

  \#で始まった場合、背景をそのRGBにする。ファイル名の場合、その画像にする。
* background-color

  \#で始まった場合、背景をそのRGBにする。

* transition

  ページ遷移を指定された方法で行う。以下がある。
  * zoom
  * slide
  * fade
  * page

## element class

* fragment

  フェードイン
* fragment fade-out

  最初は表示されているが、フェードアウトして消える。  
* fragment current-visible

  自分の番になったら、フェードインして現れる。
  終わったら、フェードアウトして消える。

* fragment grow

  大きくなる
* fragment shrink

  小さくなる

```
* grow     <!-- class="fragment grow"     -->
* fade-out <!-- class="fragment fade-out" -->
```
