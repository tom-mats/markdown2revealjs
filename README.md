# markdown2revealjs

* impress.jsとの互換のために、
  * ===== がきたら横にページを展開
  * ----- が来たら縦にページを展開

## Presentation Property

```
<!-- title=aaa -->
<!-- author=bbb -->
<!-- description=ccc -->
```

## Section Property

```
/^¥s*<!--¥s+data-xxx¥s*=¥s*yyy¥s+-->$/
```

がきたら
```
/^<!-- .slide: data-xxx=yyy -->$/
```
に差し替える。

## Item Property

```
/<!--¥s+data-class¥s*=¥s*yyy¥s*,?data-index¥s*=¥s*"¥d"¥s+-->/
```
を
```
/^<!-- .element: class="fragment yyy" data-framgment-index="¥d" -->/
```
に差し替える。
