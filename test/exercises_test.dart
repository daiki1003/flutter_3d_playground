// あなたの実装（lib/exercises/）の確認。最初は全部失敗する（未実装）のが正常。
// 実行: flutter test test/exercises_test.dart
import 'package:flutter_3d_playground/exercises/ex01_projection.dart' as e1;
import 'package:flutter_3d_playground/exercises/ex02_rotation.dart' as e2;
import 'package:flutter_3d_playground/exercises/ex03_matrix.dart' as e3;

import 'support/specs.dart';

void main() {
  lesson1Spec(e1.project);
  lesson2Spec(rotateX: e2.rotateX, rotateY: e2.rotateY);
  lesson3Spec(
    buildModel: e3.buildModel,
    projectionMatrix: e3.projectionMatrix,
    applyMatrix: e3.applyMatrix,
  );
}
