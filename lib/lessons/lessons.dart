import 'package:flutter/widgets.dart';

import 'lesson01_projection.dart';
import 'lesson02_rotation.dart';
import 'lesson03_matrix.dart';

class LessonInfo {
  const LessonInfo({
    required this.title,
    required this.summary,
    required this.builder,
  });

  final String title;
  final String summary;
  final WidgetBuilder builder;
}

final List<LessonInfo> lessons = [
  LessonInfo(
    title: '透視投影',
    summary: '3D の点を 2D の画面に落とす。遠いほど小さく見える理由。',
    builder: (_) => const Lesson01Body(),
  ),
  LessonInfo(
    title: '回転',
    summary: 'X軸・Y軸まわりの回転を sin / cos で書く。順序で結果が変わる。',
    builder: (_) => const Lesson02Body(),
  ),
  LessonInfo(
    title: '行列',
    summary: '回転・移動・投影を 4x4 行列にまとめて、掛け算 1 回で全頂点を変換する。',
    builder: (_) => const Lesson03Body(),
  ),
];

/// 今後追加する予定のレッスン（ホームに表示するだけ）。
const List<String> roadmap = [
  'カメラ（lookAt と視野角）',
  '面を塗る（奥から描く・裏面を捨てる）',
  'ライティング（法線と内積で陰影）',
  'OBJ / glTF の読み込み',
  'flutter_scene（Flutter GPU）でシェーダーに触れる',
];
