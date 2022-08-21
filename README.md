# 個人制作-就活ノート
Interface: SwiftUI のみ
Architecture: MVVM

## 開発を始めた理由
自分自身が、「あの企業はこういうサービスを展開していて、その企業は福利厚生が優秀、いついつはこの企業で説明会がある。。。」のような、就活における多種多様な情報をまとめることが難しいと感じた経験があった。
標準のメモアプリにそれらの情報を打ち込むことも別に不便ではないが、就活に特化したメモアプリを作ることでもっと生産性を上げられると考えた。
また、意外にも似たようなアプリがストアになかったこと、大学生の友人が多い現在マーケティングがしやすいことの２点から、それなりのダウンロード数が見込めた。

上記の理由により、「就活ノート」の開発を始めました。

## 工夫したこと
- 標準のメモアプリにデザイン・機能を寄せ、その上で就活に特化するような実装をしたこと
- 開発した機能をバラバラに配置するのではなく、たとえばCompanyViewからその企業のTodoが見れるような、全てが繋がるようにしたこと

## 悩んでいること
- キーボードの開閉がすごく不自然であること
- いくつかのViewで使いたい関数があり、かつそれらがViewModelとは関係ないもの(たとえばConvertIntToStars)であったときに、どのような形で参照できるようにすればいいのかがわからない（今回はSharingFuncsファイルを作り、そこにすべて詰め込んだ）
- コードチェックなどの際に「コードが長くて見づらい」のようなことがたびたびあるかと思うが、具体的にどのくらいからファイルを分け始めたらいいのかがわからない（個人的にファイルを分けすぎてもレビューがしにくいのではと考えている）
- 率直に、このアプリは使いやすいか使いにくいかが知りたい

## 今後やりたいこと
- リストの表示方法を切り替える実装（ユーザーの好みで切り替えられる的な）
- ウェジット機能実装
- AddTodoViewのモーダルシートを低くする（参照: https://mjeld.com/swiftui-modal-partialsheet/)
- Firebaseを使ったTodoの通知機能実装
- Webアプリ版の開発(ログイン機能を使った（今回はユーザーがマイページなどのPW打つ場合も考えられ、それらが流出してしまった時が怖いため、一旦勉強してから実装）)
