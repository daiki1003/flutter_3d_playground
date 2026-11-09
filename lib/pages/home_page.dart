import 'package:flutter/material.dart';

import '../lessons/lessons.dart';
import '../ui/blocks.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Flutter 3D Playground',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 8),
      const Prose(
        'ライブラリを使わず、3D 描画の仕組みを自分の手で書いて学ぶ場所です。'
        '回る立方体を、投影・回転・行列の 3 ステップで組み立てます。',
      ),
      const Heading('進め方'),
      const Prose(
        '1. レッスンを読んで、お手本の動きを確認する\n'
        '2. lib/exercises/ の TODO を自分で書く（お手本は lib/solutions/ にあるので、書き終わるまで見ない）\n'
        '3. テストで確認し、画面を「自分の実装」に切り替えて、お手本と同じ絵が出るか見る',
      ),
      const Formula('flutter test test/exercises_test.dart'),
      const Heading('レッスン'),
      for (final (i, l) in lessons.indexed)
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(child: Text('${i + 1}')),
          title: Text(l.title),
          subtitle: Text(l.summary),
        ),
      const SizedBox(height: 12),
      FilledButton.icon(
        onPressed: onStart,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Lesson 1 をはじめる'),
      ),
      const Heading('今後の予定'),
      for (final r in roadmap) Prose('・$r'),
    ],
  );
}
