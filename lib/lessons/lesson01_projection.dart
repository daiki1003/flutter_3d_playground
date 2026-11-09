import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

import '../core/cube_stage.dart';
import '../exercises/ex01_projection.dart' as mine;
import '../solutions/sol01_projection.dart' as reference;
import '../ui/blocks.dart';

class Lesson01Body extends StatefulWidget {
  const Lesson01Body({super.key});

  @override
  State<Lesson01Body> createState() => _Lesson01BodyState();
}

class _Lesson01BodyState extends State<Lesson01Body> {
  Impl _impl = Impl.reference;
  double _distance = 5;
  double _focal = 300;

  @override
  Widget build(BuildContext context) {
    final project = _impl == Impl.mine ? mine.project : reference.project;
    // 中心からずらして置くと、奥行きによる収束（遠近感）が見やすい。
    final offset = Vector3(1.0, 0.6, _distance);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Prose(
          '3D の世界にある点 (x, y, z) を、2D の画面のどこに描くか。'
          'いちばん単純なモデルは「ピンホールカメラ」です。カメラは原点にあって +z 方向を向いています。',
        ),
        const Heading('遠いものは小さく見える'),
        const Prose(
          '同じ大きさのものでも、遠く（z が大きい）にあるほど小さく見えます。'
          'つまり x と y を z で割れば、遠近感が出ます。焦点距離 f は「どれだけ拡大して見せるか」の係数です。',
        ),
        const Formula(
          'screenX =  f * x / z\nscreenY = -f * y / z   // 画面は y が下向きなので符号を反転',
        ),
        const Heading('動かして確かめる'),
        ImplToggle(value: _impl, onChanged: (v) => setState(() => _impl = v)),
        const SizedBox(height: 12),
        CubeStage(
          transformAll: (vs) => [
            for (final v in vs) project(v + offset, _focal),
          ],
        ),
        const SizedBox(height: 8),
        LabeledSlider(
          label: '奥行き z',
          value: _distance,
          min: 3,
          max: 12,
          onChanged: (v) => setState(() => _distance = v),
        ),
        LabeledSlider(
          label: '焦点距離 f',
          value: _focal,
          min: 100,
          max: 600,
          onChanged: (v) => setState(() => _focal = v),
        ),
        const Prose(
          '立方体の手前の面（大きい四角）と奥の面（小さい四角）を見比べてみてください。'
          '奥行きを大きくすると全体が小さくなり、中心へ寄っていきます。',
        ),
        const ExerciseBox(
          file: 'lib/exercises/ex01_projection.dart',
          task: 'project() を実装して、「自分の実装」に切り替えたときにお手本と同じ立方体が出れば完成です。',
          testCommand:
              'flutter test test/exercises_test.dart --plain-name "Lesson 1"',
        ),
        const HintTile(
          'Offset(dx, dy) を返すだけです。p.x, p.y, p.z を使い、割り算は 2 回。'
          'y の符号を反転し忘れると、立方体が上下逆さまに見えます。',
        ),
      ],
    );
  }
}
