import 'package:flutter/material.dart';
import 'package:glass_morph/glass_morph.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'glass_morph Example',
        home: Scaffold(
          appBar: AppBar(title: const Text('glass_morph demo')),
          body: const DemoPage(),
        ),
      );
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
      ),
      child: Center(
        child: GlassMorphButton(
          onPressed: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Pressed'))),
          child: const Text('Upgrade to Pro'),
        ),
      ),
    );
  }
}
