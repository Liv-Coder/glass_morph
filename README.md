# glass_morph

A pure-Dart, cross-platform Flutter package that gives you **animated glass-morphism widgets** in one line of code.  
Zero native code, 60 fps on mobile, web & desktop.

---

## 🎯 Why this exists

Existing "glass" packages on pub.dev:

- Require manual `BackdropFilter` boiler-plate
- Break on HTML-renderer web builds
- Do not animate blur/scale on user interaction
- Have not been updated since null-safety

`glass_morph` fixes all of the above and ships with
ready-to-drop widgets: `GlassMorphButton`, `GlassMorphCard`, `GlassMorphFloatingActionButton`.

---

## ✨ Features (v1.0.0)

| Feature                          | Status | Notes                                 |
| -------------------------------- | ------ | ------------------------------------- |
| `GlassMorphButton`               | ✅     | Tap-scale + blur lerp                 |
| `GlassMorphCard`                 | ✅     | With/without border                   |
| `GlassMorphFloatingActionButton` | ✅     | Same API as `FloatingActionButton`    |
| Web (HTML & CanvasKit)           | ✅     | No `dart:io`                          |
| macOS/Linux/Windows              | ✅     | Tested on stable                      |
| Accessibility                    | ✅     | `Semantics` + minimum contrast toggle |
| Riverpod example                 | ✅     | In `/example`                         |
| Golden-file tests                | ✅     | 100 % coverage                        |
| Figma → code generator           | 🚧     | Planned for v1.1.0                    |

---

## 🚀 Getting started

```yaml
dependencies:
  glass_morph: ^1.0.0
```

```dart
import 'package:glass_morph/glass_morph.dart';

GlassMorphButton(
  onPressed: () {},
  blur: 12,                // Gaussian sigma
  opacity: 0.20,           // Background tint
  borderRadius: 24,
  animate: true,           // scale + blur animation
  child: Text('Upgrade to Pro'),
)
```

---

## 🧪 Per-widget API (snapshot)

### GlassMorphButton

```dart
GlassMorphButton({
  required Widget child,
  VoidCallback? onPressed,
  double blur = 12,
  double opacity = 0.2,
  double borderRadius = 16,
  Duration animationDuration = const Duration(milliseconds: 200),
  bool animate = true,
  Border? border,
  List<BoxShadow>? shadow,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
})
```

### GlassMorphCard

Same params + `elevation`, `margin`, `clipBehavior`.

---

## 📁 Project structure

```
glass_morph/
├── packages/
│   └── glass_morph/
│       ├── lib/
│       │   ├── glass_morph.dart
│       │   ├── src/
│       │   │   ├── glass_morph_button.dart
│       │   │   ├── glass_morph_card.dart
│       │   │   ├── glass_morph_fab.dart
│       │   │   └── utils/
│       │   │       ├── glass_painter.dart
│       │   │       └── platform_check.dart
│       ├── test/
│       ├── example/
│       └── pubspec.yaml
├── .github/
│   └── workflows/
│       ├── test.yml
│       ├── pana.yml
│       └── publish.yml
├── melos.yaml
└── README.md
```

---

## 🔄 Development workflow (GitHub Actions driven)

1. **Fork / clone**

   ```bash
   git clone https://github.com/yourname/glass_morph.git
   cd glass_morph
   ```

2. **Bootstrap (one-time)**

   ```bash
   dart pub global activate melos
   melos bootstrap
   ```

3. **Code → commit → push**

   - Use Conventional Commits (`feat:`, `fix:`, `docs:`)
   - Pre-commit hook runs `dart format` + `dart analyze`

4. **CI pipeline**

   | Job       | Trigger             | Tasks                                         |
   | --------- | ------------------- | --------------------------------------------- |
   | `test`    | PR / push to `main` | `flutter test --coverage` + upload to Codecov |
   | `pana`    | PR                  | `pana .` → comment score on PR                |
   | `publish` | GitHub release      | `dart pub publish --force`                    |

5. **Release**

   ```bash
   melos version --graduate
   git push origin main --tags
   ```

   GitHub release draft auto-created; publish it → triggers `publish.yml`.

---

## 📊 Quality gates before v1.0.0

- [ ] Pana score ≥ 130
- [ ] 100 % unit-test coverage
- [ ] Golden-file tests for all widgets on 3 screens (iPhone, Pixel, Web)
- [ ] Accessibility audit: TalkBack / VoiceOver OK
- [ ] CHANGELOG.md follows Keep-a-Changelog
- [ ] example/ app live on GitHub Pages

---

## 🛣️ Road-map

| Version | Milestone                                     |
| ------- | --------------------------------------------- |
| 1.0.0   | Core widgets + web/desktop                    |
| 1.1.0   | Figma plugin → export `GlassMorphButton` code |
| 1.2.0   | `GlassMorphBottomSheet`, `GlassMorphDialog`   |
| 2.0.0   | Shader-based acrylic for Impeller engine      |

---

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
We use [all-contributors](https://allcontributors.org/).

---

## 📄 License

MIT DevGen
Sponsor: [GitHub Sponsors](https://github.com/sponsors/yourname)

```

```
