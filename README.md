# glass_morph

A pure-Dart, cross-platform Flutter package providing animated glass-morphism widgets: GlassMorphButton, GlassMorphCard, GlassMorphFloatingActionButton.

## Features

- Animated blur + scale interactions
- Pure Dart (no native plugins) — works on mobile, desktop & web (HTML/CanvasKit)
- Accessible defaults (Semantics, contrast)

## Installation

Add to your pubspec.yaml:

```yaml
dependencies:
  glass_morph: ^1.0.0
```

## Quick example

```dart
import 'package:glass_morph/glass_morph.dart';

GlassMorphButton(
  onPressed: () {},
  child: Text('Upgrade to Pro'),
);
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
