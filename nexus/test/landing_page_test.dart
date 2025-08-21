import 'package:flutter_test/flutter_test.dart';
import 'package:nexus/main.dart';

void main() {
  testWidgets('Landing page displays poem', (WidgetTester tester) async {
    await tester.pumpWidget(const NexusApp());
    expect(find.textContaining('Under starlit skies'), findsOneWidget);
  });
}

