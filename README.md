# ```KChem``` 有機化学勉強アプリ

## Screenshots
![screenshot_0](/screenshot/screenshots.png)

## 概要
高校生向けの有機化学の内容を暗記するアプリです

[Apple Store ↗︎](https://apps.apple.com/jp/app/kchem-効率よく暗記する高校有機化学/id1601032155)

## 背景
自らが起業した個人塾の生徒から、家でも有機化学を勉強したいという要望があり作成しました。大学２年生の時に作成し、作成期間は3ヶ月ほどです。

## 工夫点
- 一問一答の形式ではなく、赤シートで隠す出題形式にすることで網羅的な学習を可能にしました
- サブスクリプションの実装も行い、開発からストア公開までを実施しました。実際に収益も少しですが上げております

## 使用技術
- 言語：```Swift```
- フレームワーク: ```UIKit```

## 補足事項
- サブスクリプションの際に必要な ```ProductID``` は ```XXXXX``` で置き換えています
- サブスクリプションに登録しないと表示できないコンテンツは削除しています

## 今後の展望
```SwiftUI```や```Flutter```のような宣言型のフレームワークを用いて、より網羅的に学習できる新しいアプリとサービスを展開したいです。

また、クラス設計やデザインパターンにも興味が出てきたため、保守性や拡張性の高いコードを書けるように勉強中です。勉強してコードを書けば書くほど楽しいと感じています🔥

## 利用したパッケージ
- [SwiftyStoreKit](https://github.com/bizz84/SwiftyStoreKit)
  - Contributor: [Andrea Bizzotto](https://github.com/bizz84)
  - レシートの検証がとても楽になりました！ありがとうございます！（I would like to extend my heartfelt gratitude for the package that has made receipt verification a breeze. Thank you!
）
