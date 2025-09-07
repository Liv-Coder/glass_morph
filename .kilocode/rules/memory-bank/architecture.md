# architecture.md

Overview

glass_morph is a lightweight, feature-focused Flutter package organized as a workspace package under packages/glass_morph. It follows a simple, testable structure with UI widgets, utilities, and examples separated for clarity.

Source layout

- lib/
  - glass_morph.dart (public API)
  - src/
    - glass_morph_button.dart
    - glass_morph_card.dart
    - glass_morph_fab.dart
    - utils/
      - glass_painter.dart
      - platform_check.dart
- example/ (demo app)
- test/ (unit and golden tests)
- docs/ (documentation)
- .github/workflows/
  - ci.yml (test, pana, coverage)
  - gh-pages.yml (deploy example to GitHub Pages)

Key design decisions

- Pure Dart implementation: no native plugins to maximize portability (mobile, web HTML and CanvasKit, desktop).
- Feature-based separation: each widget lives in its own file and exposes a minimal public API.
- Performance-first: animations and rendering optimized for 60 fps; golden tests ensure visual stability.
- Accessibility: Semantics and contrast options are built into widget defaults.

Testing & CI

- Golden-file tests for visual regression.
- Unit tests cover widget behavior.
- CI pipeline runs `flutter test --coverage`, `pana`, and publish checks via GitHub Actions.

Integration points

- Example app demonstrates Riverpod usage (examples/).
- Melos used for monorepo management and package bootstrapping.

Maintenance notes

- Keep public API stable in `glass_morph.dart`.
- Place new components under src/ and add tests in test/.
