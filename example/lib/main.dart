import 'package:example/theme/theme.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const GlassMorphExampleApp());

class GlassMorphExampleApp extends StatelessWidget {
  const GlassMorphExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass Morph Widgets Demo',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
