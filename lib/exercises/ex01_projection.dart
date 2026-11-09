import 'dart:ui' show Offset;

import 'package:vector_math/vector_math_64.dart';

/// Lesson 1: 透視投影（あなたが手で書くファイル）
///
/// カメラは原点にあり、+z 方向を向いている。
/// 3D の点 [p] を、画面中心を (0, 0) とした 2D 座標（ピクセル）に変換して返す。
///
/// - [focalLength]: 焦点距離。大きいほど拡大して見える。
/// - 画面は y が下向きなので、3D の y（上向き）とは符号が逆になる。
Offset project(Vector3 p, double focalLength) {
  // TODO: ここを実装する。
  throw UnimplementedError(
    'lib/exercises/ex01_projection.dart の project() を実装してください',
  );
}
