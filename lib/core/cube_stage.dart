import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

import 'cube.dart';

/// 立方体の頂点を [transformAll] で 2D（画面中心が原点）に変換して、
/// ワイヤーフレームとして描く舞台。
///
/// [transformAll] が未実装（[UnimplementedError]）や例外を投げたときは、
/// 描画の代わりにメッセージを表示する。
class CubeStage extends StatelessWidget {
  const CubeStage({super.key, required this.transformAll});

  final List<Offset> Function(List<Vector3> vertices) transformAll;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    List<Offset>? points;
    String? error;
    try {
      // 学習者の実装が引数を破壊しても次フレームに影響しないよう複製して渡す。
      points = transformAll([for (final v in cubeVertices) v.clone()]);
      if (points.any((p) => !p.dx.isFinite || !p.dy.isFinite)) {
        points = null;
        error = '結果に NaN / Infinity が含まれています（z=0 で割っていませんか？）';
      }
    } on UnimplementedError catch (e) {
      error = '${e.message ?? '未実装です'}\n「お手本」に切り替えると動作を確認できます。';
    } catch (e) {
      error = '実装エラー: $e';
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 360,
        width: double.infinity,
        color: scheme.surfaceContainerLowest,
        child: points != null
            ? CustomPaint(painter: _WirePainter(points, scheme.primary))
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.construction,
                        color: scheme.tertiary,
                        size: 36,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        error ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _WirePainter extends CustomPainter {
  _WirePainter(this.points, this.color);

  final List<Offset> points;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    final axis = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(-size.width / 2, 0),
      Offset(size.width / 2, 0),
      axis,
    );
    canvas.drawLine(
      Offset(0, -size.height / 2),
      Offset(0, size.height / 2),
      axis,
    );

    final line = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (final (a, b) in cubeEdges) {
      canvas.drawLine(points[a], points[b], line);
    }
    final dot = Paint()..color = color;
    for (final p in points) {
      canvas.drawCircle(p, 3.5, dot);
    }
  }

  @override
  bool shouldRepaint(_WirePainter oldDelegate) => true;
}
