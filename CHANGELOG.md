# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-09-08

### Added

- **GlassMorphAppBar**: New app bar widget with glass-morphism effects, supporting all standard AppBar parameters plus blur, opacity, and animation controls
- **Advanced Border Configurations**: Enhanced border customization with gradient borders, dashed borders, and complex border styles
- **Validation Utilities**: Comprehensive parameter validation with helpful error messages and input sanitization
- **Spring Animations**: Physics-based spring animations with customizable damping and stiffness for natural motion
- **Custom Curves**: Support for custom animation curves including elastic, bounce, and ease-in-out variations
- **Gradient Backgrounds**: Linear, radial, and sweep gradient support for glass morphism effects with predefined presets (ocean, sunset, aurora, etc.)
- **Performance Optimizations**: Reduced widget rebuilds, optimized animation performance, and improved rendering efficiency
- **Haptic Feedback**: Platform-specific haptic feedback integration for interactive elements
- **Accessibility Enhancements**: Better screen reader support, improved focus management, and enhanced semantic labels
- **Widget Customization Presets**: Predefined style configurations (minimal, elegant, bold) for quick theming
- **Dynamic Blur**: Scroll velocity-based blur adjustments for enhanced visual feedback
- **Custom Border Styles**: Advanced shadow effects and border styling options
- **Error Handling**: Robust error recovery and graceful failure handling
- **Widget Variants**: Outlined, filled, and ghost style variants for all glass morphism widgets
- **State Persistence**: Configuration saving and restoration capabilities

## [1.0.0] - 2025-09-07

### Added

- **Core Widgets**: `GlassMorphButton`, `GlassMorphCard`, `GlassMorphFloatingActionButton` with animated glass-morphism effects
- **Cross-platform Support**: Pure Dart implementation supporting mobile, web (HTML/CanvasKit), and desktop platforms
- **Accessibility Features**:
  - MediaQuery.highContrast handling for improved visibility
  - reduceMotion support for users with motion sensitivity
  - Semantics labels and onTapHint for assistive technologies
- **Testing Infrastructure**:
  - Golden-file tests for visual regression testing
  - Unit tests covering widget behavior
  - 100% test coverage
- **CI/CD Pipeline**:
  - GitHub Actions workflows for automated testing, pana analysis, and coverage reporting
  - GitHub Pages deployment for example app
- **Documentation**: Comprehensive README with installation, usage examples, and API documentation
- **Example App**: Interactive demo showcasing all widgets with Riverpod state management

### Changed

- Updated deprecated API usage:
  - `withOpacity` → `withValues` for Color handling
  - `translate` → `translate` with proper Matrix4 method calls
- Enhanced widget APIs with better parameter defaults and accessibility options
- Improved error handling and platform compatibility checks

### Fixed

- Matrix4.translate method usage in glass_morph_button.dart
- GitHub Actions workflow compatibility (removed unsupported --web-renderer option)
- Widget parameter inconsistencies and deprecated method calls
- Accessibility compliance issues across all widgets

### Technical Improvements

- Performance optimizations for 60fps animations
- Pure Dart implementation with no native plugin dependencies
- Modular architecture with feature-based separation
- Comprehensive linting and formatting standards
