import 'package:flutter/material.dart';
import 'package:flutter_3d_playground/app.dart';
import 'package:flutter_test/flutter_test.dart';

/// 左のナビ（ListView）内の項目。ホーム本文のレッスン一覧と区別する。
Finder navItem(String title) =>
    find.descendant(of: find.byType(ListView), matching: find.text(title));

void main() {
  testWidgets('ホームから各レッスンを開ける（お手本では例外が出ない）', (tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PlaygroundApp());
    expect(find.text('Lesson 1 をはじめる'), findsOneWidget);

    for (final title in ['透視投影', '回転', '行列']) {
      await tester.tap(navItem(title));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('あなたの課題'), findsOneWidget, reason: title);
      expect(tester.takeException(), isNull, reason: title);
    }
  });

  testWidgets('自分の実装が未実装なら、例外ではなくメッセージを出す', (tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PlaygroundApp());
    await tester.tap(navItem('透視投影'));
    await tester.pump();
    await tester.tap(find.text('自分の実装'));
    await tester.pump();

    expect(find.textContaining('を実装してください'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
