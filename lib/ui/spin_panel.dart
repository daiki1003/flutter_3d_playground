import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'blocks.dart';

/// X/Y 軸まわりの回転角を持ち、自動回転とスライダー操作を提供する。
/// [builder] には現在の回転角（ラジアン）が渡される。
class SpinPanel extends StatefulWidget {
  const SpinPanel({super.key, required this.builder});

  final Widget Function(BuildContext context, double rx, double ry) builder;

  @override
  State<SpinPanel> createState() => _SpinPanelState();
}

class _SpinPanelState extends State<SpinPanel>
    with SingleTickerProviderStateMixin {
  static const _twoPi = 2 * math.pi;

  late final Ticker _ticker;
  Duration _last = Duration.zero;
  double _rx = 0.5;
  double _ry = 0.7;
  bool _auto = true;

  @override
  void initState() {
    super.initState();
    // late final の遅延初期化だと dispose まで作られないので、ここで明示的に作って開始する。
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    if (!_auto) return;
    setState(() {
      _rx = (_rx + dt * 0.5) % _twoPi;
      _ry = (_ry + dt * 0.9) % _twoPi;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      widget.builder(context, _rx, _ry),
      const SizedBox(height: 8),
      LabeledSlider(
        label: 'X軸回転',
        value: _rx,
        min: 0,
        max: _twoPi,
        onChanged: (v) => setState(() => _rx = v),
      ),
      LabeledSlider(
        label: 'Y軸回転',
        value: _ry,
        min: 0,
        max: _twoPi,
        onChanged: (v) => setState(() => _ry = v),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('自動で回す'),
        value: _auto,
        onChanged: (v) => setState(() => _auto = v),
      ),
    ],
  );
}
