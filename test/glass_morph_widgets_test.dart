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
              child: const Text('Test Button'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);

    await tester.tap(find.text('Test Button'));
    await tester.pumpAndSettle();

    expect(pressed, isTrue);
  });

  testWidgets('GlassMorphCard builds and exposes semantics',
      (WidgetTester tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: GlassMorphCard(
              onTap: () => tapped = true,
              child: const Text('Test Card'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Card'), findsOneWidget);

    // Ensure semantics label is present when the child is Text
    final semantics = tester.getSemantics(find.text('Test Card'));
    expect(semantics, isNotNull);

    await tester.tap(find.text('Test Card'));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  testWidgets('GlassMorphFAB builds and responds to tap',
      (WidgetTester tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: GlassMorphFloatingActionButton(
              semanticsLabel: 'Add',
              onPressed: () => tapped = true,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Add'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Add'));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  // Golden tests: these will compare against golden files placed under test/goldens/.
  // Run with `flutter test --update-goldens` to generate/update the baseline images.
  testWidgets('Golden: GlassMorphButton appearance',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: GlassMorphButton(
              onPressed: () {},
              child: const Text('Golden Button'),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(GlassMorphButton),
      matchesGoldenFile('goldens/glass_morph_button.png'),
    );
  });

  testWidgets('Golden: GlassMorphCard appearance', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: GlassMorphCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Golden Card', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Card subtitle',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(GlassMorphCard),
      matchesGoldenFile('goldens/glass_morph_card.png'),
    );
  });

  testWidgets('Golden: GlassMorphFAB appearance', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: GlassMorphFloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(GlassMorphFloatingActionButton),
      matchesGoldenFile('goldens/glass_morph_fab.png'),
    );
  });
}
