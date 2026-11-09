import 'package:flutter/material.dart';

/// 小見出し。
class Heading extends StatelessWidget {
  const Heading(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 8),
    child: Text(text, style: Theme.of(context).textTheme.titleLarge),
  );
}

/// 本文。
class Prose extends StatelessWidget {
  const Prose(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8),
    ),
  );
}

/// 数式・コード片（等幅）。
class Formula extends StatelessWidget {
  const Formula(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SelectableText(
        text,
        style: const TextStyle(
          fontFamily: 'Menlo',
          fontFamilyFallback: ['monospace'],
          height: 1.6,
        ),
      ),
    );
  }
}

/// 「あなたの課題」ボックス。手で書くファイルとテストコマンドを示す。
class ExerciseBox extends StatelessWidget {
  const ExerciseBox({
    super.key,
    required this.file,
    required this.task,
    required this.testCommand,
  });

  final String file;
  final String task;
  final String testCommand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.tertiary.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit_note, color: scheme.tertiary),
              const SizedBox(width: 8),
              Text('あなたの課題', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 10),
          Text(task, style: const TextStyle(height: 1.7)),
          const SizedBox(height: 10),
          const Text('書くファイル'),
          Formula(file),
          const Text('確認コマンド'),
          Formula(testCommand),
        ],
      ),
    );
  }
}

/// 折りたたみのヒント。
class HintTile extends StatelessWidget {
  const HintTile(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => ExpansionTile(
    tilePadding: EdgeInsets.zero,
    leading: const Icon(Icons.lightbulb_outline),
    title: const Text('ヒント（詰まったら開く）'),
    childrenPadding: const EdgeInsets.only(bottom: 12),
    expandedAlignment: Alignment.centerLeft,
    children: [Text(text, style: const TextStyle(height: 1.7))],
  );
}

/// ラベル付きスライダー。
class LabeledSlider extends StatelessWidget {
  const LabeledSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(width: 96, child: Text(label)),
      Expanded(
        child: Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ),
      SizedBox(
        width: 52,
        child: Text(value.toStringAsFixed(2), textAlign: TextAlign.end),
      ),
    ],
  );
}

/// 「自分の実装」と「お手本」の切り替え。
enum Impl { mine, reference }

class ImplToggle extends StatelessWidget {
  const ImplToggle({super.key, required this.value, required this.onChanged});

  final Impl value;
  final ValueChanged<Impl> onChanged;

  @override
  Widget build(BuildContext context) => SegmentedButton<Impl>(
    segments: const [
      ButtonSegment(
        value: Impl.reference,
        label: Text('お手本'),
        icon: Icon(Icons.menu_book),
      ),
      ButtonSegment(
        value: Impl.mine,
        label: Text('自分の実装'),
        icon: Icon(Icons.edit),
      ),
    ],
    selected: {value},
    onSelectionChanged: (s) => onChanged(s.first),
  );
}
