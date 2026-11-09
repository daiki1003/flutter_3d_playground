import 'dart:math' as math;

import 'package:vector_math/vector_math_64.dart';

/// Lesson 2 のお手本。まず自分で書いてから見ること。
Vector3 rotateX(Vector3 p, double angle) {
  final c = math.cos(angle), s = math.sin(angle);
  return Vector3(p.x, p.y * c - p.z * s, p.y * s + p.z * c);
}

Vector3 rotateY(Vector3 p, double angle) {
  final c = math.cos(angle), s = math.sin(angle);
  return Vector3(p.x * c + p.z * s, p.y, -p.x * s + p.z * c);
}
