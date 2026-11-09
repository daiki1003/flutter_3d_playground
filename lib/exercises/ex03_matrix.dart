import 'dart:ui' show Offset;

import 'package:vector_math/vector_math_64.dart';

/// Lesson 3: 行列（あなたが手で書くファイル）
///
/// 物体を「X軸回転 → Y軸回転 → z 方向に [distance] だけ平行移動」する 4x4 行列を返す。
/// 点に左から掛けて使う（M * p）ので、掛け算の並び順に注意。
Matrix4 buildModel({
  required double rx,
  required double ry,
  required double distance,
}) {
  // TODO: ここを実装する。
  throw UnimplementedError(
    'lib/exercises/ex03_matrix.dart の buildModel() を実装してください',
  );
}

/// Lesson 1 の透視投影を 4x4 行列で表したものを返す。
///
/// 同次座標 (x, y, z, 1) に掛けたとき、結果の w が z になるようにしておき、
/// あとで [applyMatrix] が x, y を w で割ると Lesson 1 と同じ結果になる。
Matrix4 projectionMatrix(double focalLength) {
  // TODO: ここを実装する。
  throw UnimplementedError(
    'lib/exercises/ex03_matrix.dart の projectionMatrix() を実装してください',
  );
}

/// 行列 [m] を点 [p]（同次座標 w=1）に掛け、w で割って 2D 座標にして返す。
/// `Matrix4.transform` などの便利メソッドは使わず、要素 (`m.entry(行, 列)`) から計算してみよう。
Offset applyMatrix(Matrix4 m, Vector3 p) {
  // TODO: ここを実装する。
  throw UnimplementedError(
    'lib/exercises/ex03_matrix.dart の applyMatrix() を実装してください',
  );
}
