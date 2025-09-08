# glass_morph_widgets

[![pub package](https://img.shields.io/pub/v/glass_morph_widgets.svg)](https://pub.dev/packages/glass_morph_widgets)
[![pub points](https://img.shields.io/pub/points/glass_morph_widgets)](https://pub.dev/packages/glass_morph_widgets/score)
[![GitHub Actions](https://img.shields.io/github/actions/workflow/status/Liv-Coder/glass_morph_widgets/ci.yml)](https://github.com/Liv-Coder/glass_morph_widgets/actions)

A pure-Dart, cross-platform Flutter package providing animated glass-morphism widgets with advanced features: GlassMorphButton, GlassMorphCard, GlassMorphFloatingActionButton, GlassMorphAppBar, GlassMorphBottomSheet, GlassMorphDialog.

## Demo

[![Demo](https://img.shields.io/badge/Demo-GitHub%20Pages-blue)](https://liv-coder.github.io/glass_morph_widgets/)
_Live demo showcasing all glass-morphism widgets_

## Features

- **Animated blur + scale interactions** with spring physics and custom curves
- **Gradient backgrounds** for enhanced glass effects (linear, radial, sweep gradients)
- **Advanced animations** with haptic feedback and dynamic blur based on scroll velocity
- **Widget customization presets** (minimal, elegant, bold styles)
- **Theme-aware colors** with automatic light/dark mode support
- **Pure Dart implementation** (no native plugins) — works on mobile, desktop & web (HTML/CanvasKit)
- **Accessibility compliant** (Semantics, contrast, reduce motion support)
- **Internationalization ready** with configurable semantic labels
- **Performance optimized** for 60 fps animations with golden-file tests for visual regression
- **Widget state persistence** with SharedPreferences integration
- **Comprehensive error handling** with graceful fallbacks
- CI/CD pipeline with GitHub Actions

## Screenshots

### GlassMorphButton

![GlassMorphButton](https://raw.githubusercontent.com/Liv-Coder/glass_morph_widgets/main/screenshots/glass_morph_button.png)

### GlassMorphCard

![GlassMorphCard](https://raw.githubusercontent.com/Liv-Coder/glass_morph_widgets/main/screenshots/glass_morph_card.png)

### GlassMorphFloatingActionButton

![GlassMorphFloatingActionButton](https://raw.githubusercontent.com/Liv-Coder/glass_morph_widgets/main/screenshots/glass_morph_fab.png)

### GlassMorphAppBar

![GlassMorphAppBar](https://raw.githubusercontent.com/Liv-Coder/glass_morph_widgets/main/screenshots/glass_morph_app_bar.png)

## Installation

Add to your pubspec.yaml:

```yaml
dependencies:
  glass_morph_widgets: ^1.1.0
```

## Quick example

```dart
import 'package:glass_morph_widgets/glass_morph_widgets.dart';

Scaffold(
  appBar: GlassMorphAppBar(
    title: Text('My App'),
    blur: 12,
    opacity: 0.2,
  ),
  body: Center(
    child: GlassMorphButton(
      onPressed: () {},
      child: Text('Upgrade to Pro'),
    ),
  ),
);
```

## Advanced Usage Examples

### Gradient Backgrounds

```dart
GlassMorphButton(
  onPressed: () {},
  blur: 15,
  opacity: 0.3,
  gradientConfig: GlassGradientConfig.ocean, // Predefined gradient
  child: Text('Ocean Theme'),
)

// Custom gradient
GlassMorphButton(
  onPressed: () {},
  blur: 12,
  opacity: 0.25,
  gradientConfig: GlassGradientConfig.linear(
    colors: [Colors.purple, Colors.blue, Colors.cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  child: Text('Custom Gradient'),
)
```

### Advanced Animations

```dart
GlassMorphCard(
  blur: 20,
  opacity: 0.2,
  animationDuration: Duration(milliseconds: 300),
  animationCurve: Curves.elasticOut, // Spring-like animation
  hapticFeedback: true, // Haptic feedback on tap
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Text('Spring Animation with Haptic'),
  ),
)
```

### Dynamic Blur with Scroll

```dart
NotificationListener<ScrollNotification>(
  onNotification: (notification) {
    if (notification is ScrollUpdateNotification) {
      // Update blur based on scroll velocity
      setState(() {
        blurAmount = (notification.scrollDelta ?? 0).abs().clamp(5, 25);
      });
    }
    return true;
  },
  child: GlassMorphAppBar(
    title: Text('Dynamic Blur'),
    blur: blurAmount, // Dynamic blur value
    opacity: 0.3,
  ),
)
```

### Widget Customization Presets

```dart
// Minimal style
GlassMorphButton(
  onPressed: () {},
  style: GlassMorphStyle.minimal,
  child: Text('Minimal'),
)

// Elegant style
GlassMorphCard(
  style: GlassMorphStyle.elegant,
  child: Text('Elegant Card'),
)

// Bold style
GlassMorphFloatingActionButton(
  onPressed: () {},
  style: GlassMorphStyle.bold,
  child: Icon(Icons.add),
)
```

### Accessibility Features

```dart
GlassMorphButton(
  onPressed: () {},
  semanticLabel: 'Open settings menu', // Custom accessibility label
  excludeFromSemantics: false, // Include in accessibility tree
  child: Icon(Icons.settings),
)
```

### Theme-Aware Colors

```dart
// Automatically adapts to light/dark theme
GlassMorphCard(
  blur: 15,
  opacity: 0.25,
  // Colors automatically adjust based on Theme.of(context).colorScheme
  child: Text('Theme Aware'),
)
```

## Running tests & goldens

- Generate golden baselines:

  ```bash
  flutter test --update-goldens
  ```

- Run tests:

  ```bash
  flutter test
  dart analyze
  ```

## CI

- CI should run `flutter test` and fail on visual diffs. Do not run `--update-goldens` in CI.

## Contributing

- Follow Conventional Commits.
- Run `dart format .` and `dart analyze` before committing.

## License

MIT License — see LICENSE.
