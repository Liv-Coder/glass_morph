import 'package:flutter/material.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'glass_morph Example',
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('glass_morph demo')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Card demo
                GlassMorphCard(
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  borderRadius: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'GlassMorphCard',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'This is an example card using glass_morph.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Button demo
                GlassMorphButton(
                  animate: true,
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Button pressed'))),
                  child: const Text('Upgrade to Pro'),
                ),
                const SizedBox(height: 24),
                // Inline FAB-like button demo
                GlassMorphFloatingActionButton(
                  semanticsLabel: 'Demo FAB',
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('FAB pressed'))),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GlassMorphFloatingActionButton(
        semanticsLabel: 'Add',
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FloatingActionButton pressed'))),
        child: const Icon(Icons.add),
      ),
    );
  }
}
