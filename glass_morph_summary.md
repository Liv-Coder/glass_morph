# glass_morph — Project summary

glass_morph is a pure‑Dart, cross‑platform Flutter package that delivers high‑performance, animated glass‑morphism widgets (buttons, cards, FAB) with a single-line API and no native code.

Objectives

- Eliminate BackdropFilter boilerplate and provide consistent glass visuals across mobile, web (HTML & CanvasKit), and desktop.
- Offer animatable blur and scale interactions, accessible defaults, and drop-in widgets for fast integration.

Key features

- GlassMorphButton, GlassMorphCard, GlassMorphFloatingActionButton (tap-scale + blur lerp).
- Web-safe implementation (no dart:io) and 60 fps performance targets.
- Accessibility (Semantics, contrast toggle) and golden-file tests for visual regressions.

Technologies

- Dart, Flutter, Riverpod (examples), melos, GitHub Actions.

Significance

- Streamlines creation of modern glass-morphism UI, reduces platform inconsistencies, and accelerates developer workflows with well-tested, accessible components.
