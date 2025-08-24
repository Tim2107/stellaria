import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus/main.dart';

void main() {
  testWidgets('Poem changes when language selection changes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NexusApp());

    expect(find.textContaining('Under starlit skies'), findsOneWidget);

    await tester.tap(find.text('English'));
    await tester.pump();
    await tester.drag(find.byType(CupertinoPicker), const Offset(0, -100));
    await tester.pumpAndSettle();

    expect(find.textContaining('Unter sternenklaren Weiten'), findsOneWidget);

    await tester.drag(find.byType(CupertinoPicker), const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(find.textContaining('Pod žiarivým hviezdnym nebom'), findsOneWidget);
  });
}
