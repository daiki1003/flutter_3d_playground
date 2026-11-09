import 'package:flutter/material.dart';

import 'lessons/lessons.dart';
import 'pages/home_page.dart';
import 'ui/blocks.dart';

class PlaygroundApp extends StatelessWidget {
  const PlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter 3D Playground',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        brightness: Brightness.dark,
      ),
    ),
    home: const Shell(),
  );
}

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// null はホーム、それ以外は lessons の index。
  int? _index;

  void _select(int? i) {
    _scaffoldKey.currentState?.closeDrawer();
    setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide = constraints.maxWidth >= 900;
      final nav = _Nav(selected: _index, onSelect: _select);
      return Scaffold(
        key: _scaffoldKey,
        appBar: wide
            ? null
            : AppBar(
                title: Text(
                  _index == null
                      ? 'Flutter 3D Playground'
                      : lessons[_index!].title,
                ),
              ),
        drawer: wide ? null : Drawer(child: nav),
        body: Row(
          children: [
            if (wide) SizedBox(width: 280, child: nav),
            if (wide) const VerticalDivider(width: 1),
            Expanded(child: _content()),
          ],
        ),
      );
    },
  );

  Widget _content() {
    final i = _index;
    return SingleChildScrollView(
      key: ValueKey(i),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: i == null
              ? HomePage(onStart: () => _select(0))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lesson ${i + 1}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      lessons[i].title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Prose(lessons[i].summary),
                    lessons[i].builder(context),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () => _select(i == 0 ? null : i - 1),
                          icon: const Icon(Icons.arrow_back),
                          label: Text(i == 0 ? 'ホーム' : '前のレッスン'),
                        ),
                        if (i < lessons.length - 1)
                          FilledButton.icon(
                            onPressed: () => _select(i + 1),
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text('次のレッスン'),
                          ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Nav extends StatelessWidget {
  const _Nav({required this.selected, required this.onSelect});

  final int? selected;
  final ValueChanged<int?> onSelect;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.symmetric(vertical: 12),
    children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Flutter 3D Playground'),
        selected: selected == null,
        onTap: () => onSelect(null),
      ),
      const Divider(),
      for (final (i, l) in lessons.indexed)
        ListTile(
          leading: CircleAvatar(
            radius: 14,
            child: Text('${i + 1}', style: const TextStyle(fontSize: 12)),
          ),
          title: Text(l.title),
          selected: selected == i,
          onTap: () => onSelect(i),
        ),
    ],
  );
}
