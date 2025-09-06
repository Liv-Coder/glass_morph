# tech.md

Technologies

- Dart (stable)
- Flutter (stable)
- Riverpod (examples)
- Melos (monorepo management), pana (package analysis)
- GitHub Actions (CI)

Development setup

- melos bootstrap
- dart pub get / flutter pub get
- dart format, dart analyze
- Run tests: flutter test --coverage

Constraints

- Pure Dart implementation (no native plugins)
- Web-safe (HTML and CanvasKit); avoid dart:io

Tooling & CI

- GitHub Actions: test, pana, publish
- Pre-commit hooks: dart format, dart analyze
