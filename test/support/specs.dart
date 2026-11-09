import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

import 'package:flutter_3d_playground/solutions/sol01_projection.dart' as sol1;
import 'package:flutter_3d_playground/solutions/sol02_rotation.dart' as sol2;

void expectOffset(Offset actual, Offset expected) {
  expect(actual.dx, closeTo(expected.dx, 1e-9));
  expect(actual.dy, closeTo(expected.dy, 1e-9));
}

void expectVector(Vector3 actual, Vector3 expected) {
  expect(actual.x, closeTo(expected.x, 1e-9));
  expect(actual.y, closeTo(expected.y, 1e-9));
  expect(actual.z, closeTo(expected.z, 1e-9));
}

void lesson1Spec(Offset Function(Vector3 p, double focalLength) project) {
  group('Lesson 1: project', () {
    test('x, y を z で割って焦点距離倍する（y は反転）', () {
      expectOffset(project(Vector3(1, 2, 4), 100), const Offset(25, -50));
    });

    test('光軸上の点は画面中心に出る', () {
      expectOffset(project(Vector3(0, 0, 5), 300), Offset.zero);
    });

    test('遠いほど中心に寄る（小さく見える）', () {
      final near = project(Vector3(1, 0, 2), 100).dx;
      final far = project(Vector3(1, 0, 8), 100).dx;
      expect(near, greaterThan(far));
    });
  });
}

void lesson2Spec({
  required Vector3 Function(Vector3 p, double angle) rotateX,
  required Vector3 Function(Vector3 p, double angle) rotateY,
}) {
  group('Lesson 2: rotation', () {
    test('rotateY(90°): +x は -z へ', () {
      expectVector(rotateY(Vector3(1, 0, 0), math.pi / 2), Vector3(0, 0, -1));
    });

    test('rotateX(90°): +y は +z へ', () {
      expectVector(rotateX(Vector3(0, 1, 0), math.pi / 2), Vector3(0, 0, 1));
    });

    test('角度 0 では動かない', () {
      final p = Vector3(1, 2, 3);
      expectVector(rotateX(p, 0), p);
      expectVector(rotateY(p, 0), p);
    });

    test('Matrix4.rotationX / rotationY と同じ結果になる', () {
      for (final a in [0.3, 1.1, 2.5, -0.7]) {
        final p = Vector3(1.5, -0.4, 2.2);
        expectVector(rotateX(p, a), Matrix4.rotationX(a).transformed3(p));
        expectVector(rotateY(p, a), Matrix4.rotationY(a).transformed3(p));
      }
    });

    test('引数のベクトルを書き換えない', () {
      final p = Vector3(1, 2, 3);
      rotateX(p, 0.8);
      rotateY(p, 0.8);
      expectVector(p, Vector3(1, 2, 3));
    });
  });
}

void lesson3Spec({
  required Matrix4 Function({
    required double rx,
    required double ry,
    required double distance,
  })
  buildModel,
  required Matrix4 Function(double focalLength) projectionMatrix,
  required Offset Function(Matrix4 m, Vector3 p) applyMatrix,
}) {
  group('Lesson 3: matrix', () {
    test('applyMatrix: 単位行列なら x, y がそのまま出る', () {
      expectOffset(
        applyMatrix(Matrix4.identity(), Vector3(2, 3, 4)),
        const Offset(2, 3),
      );
    });

    test('applyMatrix: w で割る', () {
      final m = Matrix4.identity()..setEntry(3, 3, 2);
      expectOffset(applyMatrix(m, Vector3(2, 4, 0)), const Offset(1, 2));
    });

    test('projectionMatrix + applyMatrix は Lesson 1 の project と一致', () {
      final p = Vector3(1, 2, 4);
      expectOffset(applyMatrix(projectionMatrix(100), p), sol1.project(p, 100));
    });

    test('buildModel は Lesson 2 の回転 + 平行移動と一致', () {
      const rx = 0.4, ry = 0.9, distance = 5.0;
      final p = Vector3(1, -1, 1);
      final expected =
          sol2.rotateY(sol2.rotateX(p, rx), ry) + Vector3(0, 0, distance);
      expectVector(
        buildModel(rx: rx, ry: ry, distance: distance).transformed3(p),
        expected,
      );
    });

    test('合成行列で変換すると Lesson 1 + 2 のパイプラインと一致', () {
      const rx = 0.4, ry = 0.9, distance = 5.0, f = 320.0;
      final p = Vector3(1, -1, 1);
      final expected = sol1.project(
        sol2.rotateY(sol2.rotateX(p, rx), ry) + Vector3(0, 0, distance),
        f,
      );
      final m =
          projectionMatrix(f) * buildModel(rx: rx, ry: ry, distance: distance);
      expectOffset(applyMatrix(m, p), expected);
    });
  });
}
