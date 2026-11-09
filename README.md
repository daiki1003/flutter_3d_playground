# flutter_3d_playground

ライブラリを使わず、3D 描画の仕組みを **自分の手で書いて** 学ぶための Flutter アプリ（学習サイト）。
回る立方体を、投影 → 回転 → 行列の順に組み立てる。

## 使い方

```bash
flutter run -d chrome        # 学習サイトを開く（macos でも可）
flutter test test/exercises_test.dart   # 自分の実装をテスト
```

1. アプリのレッスンを読み、「お手本」で動きを確認する
2. `lib/exercises/` の `TODO` を自分で書く
3. テストが通ったら、アプリで「自分の実装」に切り替えて、お手本と同じ絵が出るか確認する

最初は `exercises_test.dart` が全部失敗する（未実装）のが正常。

## 構成

| パス | 役割 |
|---|---|
| `lib/exercises/` | **自分で書く場所**（最初は `UnimplementedError`） |
| `lib/solutions/` | お手本。書き終わるまで見ない |
| `lib/lessons/` | レッスン本文とデモ |
| `lib/core/` | 立方体データとワイヤーフレーム描画 |
| `test/exercises_test.dart` | 自分の実装の確認 |
| `test/solutions_test.dart` | お手本の確認（常に通る） |

## レッスン

1. 透視投影 — `project()`
2. 回転 — `rotateX()` / `rotateY()`
3. 行列 — `buildModel()` / `projectionMatrix()` / `applyMatrix()`

今後: カメラ（lookAt）、面の塗り、ライティング、OBJ/glTF 読み込み、`flutter_scene`。
