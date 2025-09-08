import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';

void main() {
  // Light theme test group
  group('Golden Tests - Light Theme', () {
    testWidgets('GlassMorphButton - Light Theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Center(
              child: GlassMorphButton(
                onPressed: () {},
                child: const Text('Light Button'),
                blur: 12,
                opacity: 0.2,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphButton),
        matchesGoldenFile('goldens/glass_morph_button_light.png'),
      );
    });

    testWidgets('GlassMorphCard - Light Theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Center(
              child: GlassMorphCard(
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Light Card'),
                ),
                blur: 12,
                opacity: 0.2,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphCard),
        matchesGoldenFile('goldens/glass_morph_card_light.png'),
      );
    });

    testWidgets('GlassMorphFloatingActionButton - Light Theme',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: const Center(child: Text('Body')),
            floatingActionButton: GlassMorphFloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
              blur: 12,
              opacity: 0.2,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphFloatingActionButton),
        matchesGoldenFile('goldens/glass_morph_fab_light.png'),
      );
    });

    testWidgets('GlassMorphAppBar - Light Theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            appBar: GlassMorphAppBar(
              title: const Text('Light App Bar'),
              blur: 12,
              opacity: 0.2,
            ),
            body: const Center(child: Text('Body')),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphAppBar),
        matchesGoldenFile('goldens/glass_morph_app_bar_light.png'),
      );
    });
  });

  // Dark theme test group
  group('Golden Tests - Dark Theme', () {
    testWidgets('GlassMorphButton - Dark Theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: Center(
              child: GlassMorphButton(
                onPressed: () {},
                child: const Text('Dark Button'),
                blur: 12,
                opacity: 0.2,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphButton),
        matchesGoldenFile('goldens/glass_morph_button_dark.png'),
      );
    });

    testWidgets('GlassMorphCard - Dark Theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: Center(
              child: GlassMorphCard(
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Dark Card'),
                ),
                blur: 12,
                opacity: 0.2,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphCard),
        matchesGoldenFile('goldens/glass_morph_card_dark.png'),
      );
    });

    testWidgets('GlassMorphFloatingActionButton - Dark Theme',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: const Center(child: Text('Body')),
            floatingActionButton: GlassMorphFloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
              blur: 12,
              opacity: 0.2,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphFloatingActionButton),
        matchesGoldenFile('goldens/glass_morph_fab_dark.png'),
      );
    });

    testWidgets('GlassMorphAppBar - Dark Theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            appBar: GlassMorphAppBar(
              title: const Text('Dark App Bar'),
              blur: 12,
              opacity: 0.2,
            ),
            body: const Center(child: Text('Body')),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphAppBar),
        matchesGoldenFile('goldens/glass_morph_app_bar_dark.png'),
      );
    });
  });

  // High contrast theme test group
  group('Golden Tests - High Contrast Theme', () {
    testWidgets('GlassMorphButton - High Contrast',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: const ColorScheme.highContrastLight(),
          ),
          home: Scaffold(
            body: Center(
              child: GlassMorphButton(
                onPressed: () {},
                child: const Text('High Contrast Button'),
                blur: 12,
                opacity: 0.2,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphButton),
        matchesGoldenFile('goldens/glass_morph_button_high_contrast.png'),
      );
    });

    testWidgets('GlassMorphCard - High Contrast', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: const ColorScheme.highContrastLight(),
          ),
          home: Scaffold(
            body: Center(
              child: GlassMorphCard(
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('High Contrast Card'),
                ),
                blur: 12,
                opacity: 0.2,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphCard),
        matchesGoldenFile('goldens/glass_morph_card_high_contrast.png'),
      );
    });

    testWidgets('GlassMorphFloatingActionButton - High Contrast',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: const ColorScheme.highContrastLight(),
          ),
          home: Scaffold(
            body: const Center(child: Text('Body')),
            floatingActionButton: GlassMorphFloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
              blur: 12,
              opacity: 0.2,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphFloatingActionButton),
        matchesGoldenFile('goldens/glass_morph_fab_high_contrast.png'),
      );
    });

    testWidgets('GlassMorphAppBar - High Contrast',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: const ColorScheme.highContrastLight(),
          ),
          home: Scaffold(
            appBar: GlassMorphAppBar(
              title: const Text('High Contrast App Bar'),
              blur: 12,
              opacity: 0.2,
            ),
            body: const Center(child: Text('Body')),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphAppBar),
        matchesGoldenFile('goldens/glass_morph_app_bar_high_contrast.png'),
      );
    });
  });

  // Custom theme configurations
  group('Golden Tests - Custom Configurations', () {
    testWidgets('GlassMorphButton - Custom Gradient Background',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Center(
              child: GlassMorphButton(
                onPressed: () {},
                child: const Text('Gradient Button'),
                blur: 15,
                opacity: 0.3,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphButton),
        matchesGoldenFile('goldens/glass_morph_button_gradient.png'),
      );
    });

    testWidgets('GlassMorphCard - Custom Border and Shadow',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Center(
              child: GlassMorphCard(
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Custom Card'),
                ),
                blur: 20,
                opacity: 0.25,
                border: Border.all(color: Colors.blue, width: 2),
                shadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphCard),
        matchesGoldenFile('goldens/glass_morph_card_custom.png'),
      );
    });

    testWidgets('GlassMorphFloatingActionButton - Custom Size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: const Center(child: Text('Body')),
            floatingActionButton: SizedBox(
              width: 80,
              height: 80,
              child: GlassMorphFloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add, size: 36),
                blur: 18,
                opacity: 0.22,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphFloatingActionButton),
        matchesGoldenFile('goldens/glass_morph_fab_custom_size.png'),
      );
    });

    testWidgets('GlassMorphAppBar - With Actions and Leading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            appBar: GlassMorphAppBar(
              title: const Text('Custom App Bar'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              blur: 16,
              opacity: 0.18,
            ),
            body: const Center(child: Text('Body')),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphAppBar),
        matchesGoldenFile('goldens/glass_morph_app_bar_actions.png'),
      );
    });
  });

  // Animation states
  group('Golden Tests - Animation States', () {
    testWidgets('GlassMorphButton - Pressed State',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Center(
              child: GlassMorphButton(
                onPressed: () {},
                child: const Text('Pressed Button'),
                blur: 12,
                opacity: 0.2,
                animate: true,
              ),
            ),
          ),
        ),
      );

      // Simulate press
      await tester.press(find.byType(GlassMorphButton));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(GlassMorphButton),
        matchesGoldenFile('goldens/glass_morph_button_pressed.png'),
      );
    });
  });
}
