import 'dart:ui' show Offset;

import 'package:vector_math/vector_math_64.dart';

/// Lesson 1 のお手本。まず自分で書いてから見ること。
Offset project(Vector3 p, double focalLength) =>
    Offset(focalLength * p.x / p.z, -focalLength * p.y / p.z);
