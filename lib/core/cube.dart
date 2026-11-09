import 'package:vector_math/vector_math_64.dart';

/// 原点中心・一辺 2 の立方体の頂点 8 個。
/// index = (x の符号ビット)*4 + (y の符号ビット)*2 + (z の符号ビット)
final List<Vector3> cubeVertices = [
  for (final x in [-1.0, 1.0])
    for (final y in [-1.0, 1.0])
      for (final z in [-1.0, 1.0]) Vector3(x, y, z),
];

/// 1 座標だけ違う頂点同士を結んだ 12 本の辺。
final List<(int, int)> cubeEdges = [
  for (var i = 0; i < 8; i++)
    for (final bit in [1, 2, 4])
      if (i & bit == 0) (i, i | bit),
];
