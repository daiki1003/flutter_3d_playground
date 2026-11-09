import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

import '../core/cube_stage.dart';
import '../exercises/ex02_rotation.dart' as mine;
import '../solutions/sol01_projection.dart' as projection;
import '../solutions/sol02_rotation.dart' as reference;
import '../ui/blocks.dart';
import '../ui/spin_panel.dart';

class Lesson02Body extends StatefulWidget {
  const Lesson02Body({super.key});

  @override
  State<Lesson02Body> createState() => _Lesson02BodyState();
}

class _Lesson02BodyState extends State<Lesson02Body> {
  static const _distance = 5.0;
  static const _focal = 320.0;

  Impl _impl = Impl.reference;
  bool _yFirst = false;

  @override
  Widget build(BuildContext context) {
    final rotateX = _impl == Impl.mine ? mine.rotateX : reference.rotateX;
    final rotateY = _impl == Impl.mine ? mine.rotateY : reference.rotateY;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Prose(
          '立方体を回します。回転は「原点まわりに点を動かす」計算です。'
          '回したあとに z 方向へ平行移動してカメラの前へ置き、Lesson 1 の投影（お手本）で 2D にします。',
        ),
        const Heading('回転の式'),
        const Prose('Y 軸まわりに θ 回すとき、y は変わらず x と z だけが回ります。'),
        const Formula(
          'x\' =  x * cosθ + z * sinθ\ny\' =  y\nz\' = -x * sinθ + z * cosθ',
        ),
        const Prose('X 軸まわりは、x が変わらず y と z が回ります。'),
        const Formula(
          'x\' =  x\ny\' =  y * cosθ - z * sinθ\nz\' =  y * sinθ + z * cosθ',
        ),
        const Heading('動かして確かめる'),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ImplToggle(
              value: _impl,
              onChanged: (v) => setState(() => _impl = v),
            ),
            FilterChip(
              label: const Text('Y → X の順に回す'),
              selected: _yFirst,
              onSelected: (v) => setState(() => _yFirst = v),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SpinPanel(
          builder: (context, rx, ry) => CubeStage(
            transformAll: (vs) => [
              for (final v in vs)
                projection.project(
                  (_yFirst
                          ? rotateX(rotateY(v, ry), rx)
                          : rotateY(rotateX(v, rx), ry)) +
                      Vector3(0, 0, _distance),
                  _focal,
                ),
            ],
          ),
        ),
        const Prose(
          '「Y → X の順に回す」を切り替えて、同じ角度でも向きが変わることを確かめてください。'
          '回転は順番を入れ替えると結果が変わります（交換法則が成り立たない）。'
          'この性質が、Lesson 3 で行列の掛け算の順序を気にする理由になります。',
        ),
        const ExerciseBox(
          file: 'lib/exercises/ex02_rotation.dart',
          task:
              'rotateX() と rotateY() を実装します。引数のベクトルは書き換えず、新しい Vector3 を返してください。',
          testCommand:
              'flutter test test/exercises_test.dart --plain-name "Lesson 2"',
        ),
        const HintTile(
          'dart:math の sin / cos を使います。cos と sin は先に変数へ入れておくと読みやすいです。'
          '式は上の 2 つの囲みをそのまま Dart に書き写せば動きます。'
          '符号を間違えると、回る向きが逆になるか、立方体が歪みます（テストが教えてくれます）。',
        ),
      ],
    );
  }
}
