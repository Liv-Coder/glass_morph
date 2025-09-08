import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';

void main() {
  testWidgets('GlassMorphAppBar builds with title',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: GlassMorphAppBar(
            title: const Text('Test Title'),
          ),
          body: const Center(child: Text('Body')),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.byType(GlassMorphAppBar), findsOneWidget);
  });

  testWidgets('GlassMorphAppBar builds with leading and actions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: GlassMorphAppBar(
            title: const Text('Test Title'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: const Center(child: Text('Body')),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('GlassMorphAppBar exposes semantics',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: GlassMorphAppBar(
            title: const Text('Test Title'),
            semanticsLabel: 'Custom App Bar',
          ),
          body: const Center(child: Text('Body')),
        ),
      ),
    );

    // Check that the app bar has proper semantics
    final semantics = tester.getSemantics(find.byType(GlassMorphAppBar));
    expect(semantics, isNotNull);
  });

  testWidgets('GlassMorphAppBar implements PreferredSizeWidget',
      (WidgetTester tester) async {
    const appBar = GlassMorphAppBar(
      title: Text('Test Title'),
    );

    expect(appBar.preferredSize, isA<Size>());
    expect(appBar.preferredSize.height, equals(kToolbarHeight));
  });

  testWidgets('GlassMorphAppBar with bottom widget calculates correct height',
      (WidgetTester tester) async {
    const bottomWidget = PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Text('Bottom'),
    );
    const appBar = GlassMorphAppBar(
      title: Text('Test Title'),
      bottom: bottomWidget,
    );

    expect(appBar.preferredSize.height, equals(kToolbarHeight + 50));
  });

  testWidgets('GlassMorphAppBar respects custom toolbar height',
      (WidgetTester tester) async {
    const customHeight = 80.0;
    const appBar = GlassMorphAppBar(
      title: Text('Test Title'),
      toolbarHeight: customHeight,
    );

    expect(appBar.preferredSize.height, equals(customHeight));
  });

  testWidgets('GlassMorphAppBar blur parameter validation',
      (WidgetTester tester) async {
    // Test that negative blur values throw assertion error
    expect(
      () => GlassMorphAppBar(
        title: const Text('Test Title'),
        blur: -5, // Invalid negative value
      ),
      throwsAssertionError,
    );
  });

  testWidgets('GlassMorphAppBar opacity parameter validation',
      (WidgetTester tester) async {
    // Test that opacity values outside 0-1 range throw assertion error
    expect(
      () => GlassMorphAppBar(
        title: const Text('Test Title'),
        opacity: 1.5, // Invalid value > 1
      ),
      throwsAssertionError,
    );
  });

  // Golden test: visual regression testing
  testWidgets('Golden: GlassMorphAppBar appearance',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: GlassMorphAppBar(
            title: const Text('Golden App Bar'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: const Center(child: Text('Body')),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(GlassMorphAppBar),
      matchesGoldenFile('goldens/glass_morph_app_bar.png'),
    );
  });
}
