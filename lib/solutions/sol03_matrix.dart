import 'dart:ui' show Offset;

import 'package:vector_math/vector_math_64.dart';

/// Lesson 3 のお手本。まず自分で書いてから見ること。
Matrix4 buildModel({
  required double rx,
  required double ry,
  required double distance,
}) =>
    Matrix4.translationValues(0, 0, distance) *
    Matrix4.rotationY(ry) *
    Matrix4.rotationX(rx);

Matrix4 projectionMatrix(double focalLength) => Matrix4.zero()
  ..setEntry(0, 0, focalLength)
  ..setEntry(1, 1, -focalLength)
  ..setEntry(2, 2, 1)
  ..setEntry(3, 2, 1); // w = z

Offset applyMatrix(Matrix4 m, Vector3 p) {
  double row(int r) =>
      m.entry(r, 0) * p.x +
      m.entry(r, 1) * p.y +
      m.entry(r, 2) * p.z +
      m.entry(r, 3);
  final w = row(3);
  return Offset(row(0) / w, row(1) / w);
}
