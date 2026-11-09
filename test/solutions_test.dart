// お手本（lib/solutions/）が仕様を満たしていることの確認。常に通るはず。
import 'package:flutter_3d_playground/solutions/sol01_projection.dart' as s1;
import 'package:flutter_3d_playground/solutions/sol02_rotation.dart' as s2;
import 'package:flutter_3d_playground/solutions/sol03_matrix.dart' as s3;

import 'support/specs.dart';

void main() {
  lesson1Spec(s1.project);
  lesson2Spec(rotateX: s2.rotateX, rotateY: s2.rotateY);
  lesson3Spec(
    buildModel: s3.buildModel,
    projectionMatrix: s3.projectionMatrix,
    applyMatrix: s3.applyMatrix,
  );
}
