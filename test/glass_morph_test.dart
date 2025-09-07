import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';

void main() {
  testWidgets('GlassMorphButton builds and responds to tap',
      (WidgetTester tester) async {
    var pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: GlassMorphButton(
              onPressed: () => pressed = true,
              child: const Text('Test'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test'), findsOneWidget);

    await tester.tap(find.text('Test'));
    await tester.pumpAndSettle();

    expect(pressed, isTrue);
  });
}
