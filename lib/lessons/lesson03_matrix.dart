import 'package:flutter/material.dart';

import '../core/cube_stage.dart';
import '../exercises/ex03_matrix.dart' as mine;
import '../solutions/sol03_matrix.dart' as reference;
import '../ui/blocks.dart';
import '../ui/spin_panel.dart';

class Lesson03Body extends StatefulWidget {
  const Lesson03Body({super.key});

  @override
  State<Lesson03Body> createState() => _Lesson03BodyState();
}

class _Lesson03BodyState extends State<Lesson03Body> {
  static const _distance = 5.0;
  static const _focal = 320.0;

  Impl _impl = Impl.reference;

  Matrix4 _combined(double rx, double ry) {
    final build = _impl == Impl.mine ? mine.buildModel : reference.buildModel;
    final proj = _impl == Impl.mine
        ? mine.projectionMatrix
        : reference.projectionMatrix;
    return proj(_focal) * build(rx: rx, ry: ry, distance: _distance);
  }

  String _matrixText(double rx, double ry) {
    try {
      final m = _combined(rx, ry);
      return [
        for (var r = 0; r < 4; r++)
          [
            for (var c = 0; c < 4; c++)
              m.entry(r, c).toStringAsFixed(1).padLeft(9),
          ].join(' '),
      ].join('\n');
    } catch (_) {
      return '（未実装のため表示できません）';
    }
  }

  @override
  Widget build(BuildContext context) {
    final apply = _impl == Impl.mine ? mine.applyMatrix : reference.applyMatrix;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Prose(
          'Lesson 1 の投影と Lesson 2 の回転・平行移動を、すべて 4x4 の行列で表します。'
          '行列にしておくと、何段階もの変換を「掛け算 1 回」にまとめて、全頂点に同じ行列を掛けるだけで済みます。'
          'GPU が頂点を処理するやり方も、これと同じです。',
        ),
        const Heading('同次座標'),
        const Prose(
          '平行移動は 3x3 では表せません。そこで点を (x, y, z, 1) と 1 つ次元を足して扱います（同次座標）。'
          '投影は「w に z を入れて、最後に x と y を w で割る」ことで、割り算を行列の外へ出します。',
        ),
        const Formula(
          '[ f  0  0  0 ]   [x]   [ f*x ]\n'
          '[ 0 -f  0  0 ] * [y] = [-f*y ]    // 最後に x, y を w で割る\n'
          '[ 0  0  1  0 ]   [z]   [  z  ]\n'
          '[ 0  0  1  0 ]   [1]   [  z  ]  <- w = z',
        ),
        const Prose('変換の合成は右から順に適用されます。「X回転 → Y回転 → 平行移動 → 投影」なら、次のように書きます。'),
        const Formula(
          'M    = Translate * RotateY * RotateX\nMVP  = Projection * M\nscreen = (MVP * (x,y,z,1)) の x/w, y/w',
        ),
        const Heading('動かして確かめる'),
        ImplToggle(value: _impl, onChanged: (v) => setState(() => _impl = v)),
        const SizedBox(height: 12),
        SpinPanel(
          builder: (context, rx, ry) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CubeStage(
                transformAll: (vs) {
                  final m = _combined(rx, ry);
                  return [for (final v in vs) apply(m, v)];
                },
              ),
              const SizedBox(height: 8),
              const Text('いま全頂点に掛けている行列 (Projection * M)'),
              Formula(_matrixText(rx, ry)),
            ],
          ),
        ),
        const Prose('見た目は Lesson 2 とまったく同じですが、頂点ごとの計算は「行列を 1 回掛ける」だけになっています。'),
        const ExerciseBox(
          file: 'lib/exercises/ex03_matrix.dart',
          task:
              'buildModel() / projectionMatrix() / applyMatrix() の 3 つを実装します。',
          testCommand:
              'flutter test test/exercises_test.dart --plain-name "Lesson 3"',
        ),
        const HintTile(
          'buildModel: Matrix4.translationValues / rotationY / rotationX を * でつなぎます。順序は上の M の式のとおり。\n'
          'projectionMatrix: Matrix4.zero() から setEntry(行, 列, 値) で 4 か所を埋めます。上の行列を見ながら。\n'
          'applyMatrix: 行 r の結果は m.entry(r,0)*x + m.entry(r,1)*y + m.entry(r,2)*z + m.entry(r,3)。'
          'これを行 0, 1, 3 について計算し、行 0 と 1 を行 3（= w）で割ります。',
        ),
      ],
    );
  }
}
