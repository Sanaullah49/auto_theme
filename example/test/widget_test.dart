import 'package:flutter_test/flutter_test.dart';

import 'package:auto_theme_example/main.dart';

void main() {
  testWidgets('example app renders the demo screen', (tester) async {
    await tester.pumpWidget(const DemoApp());
    await tester.pumpAndSettle();

    expect(find.text('Auto Theme Demo'), findsOneWidget);
    expect(find.text('Current mode'), findsOneWidget);
    expect(find.text('Controls'), findsOneWidget);
  });
}
