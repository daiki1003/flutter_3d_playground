import 'package:vector_math/vector_math_64.dart';

/// Lesson 2: 回転（あなたが手で書くファイル）
///
/// 原点まわりに点 [p] を [angle]（ラジアン）だけ回して、新しい Vector3 を返す。
/// 引数の [p] は書き換えないこと（呼び出し側が同じ頂点を使い回すため）。
///
/// 向きの規約は `Matrix4.rotationX` と同じ:
/// X 軸の正の側から原点を見て、y 軸が z 軸に近づく向きが正。
Vector3 rotateX(Vector3 p, double angle) {
  // TODO: ここを実装する。
  throw UnimplementedError(
    'lib/exercises/ex02_rotation.dart の rotateX() を実装してください',
  );
}

/// Y 軸まわりの回転。向きは `Matrix4.rotationY` と同じ（z 軸が x 軸に近づく向きが正）。
Vector3 rotateY(Vector3 p, double angle) {
  // TODO: ここを実装する。
  throw UnimplementedError(
    'lib/exercises/ex02_rotation.dart の rotateY() を実装してください',
  );
}
