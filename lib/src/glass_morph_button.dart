import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:vector_math/vector_math_64.dart' show Vector3;

/// A lightweight, drop-in animated glass-morphism button.
///
/// Usage:
/// ```dart
/// GlassMorphButton(
///   onPressed: () {},
///   child: Text('Upgrade'),
/// )
/// ```
class GlassMorphButton extends StatefulWidget {
  /// Adds optional semantic overrides for accessibility.
  const GlassMorphButton({
    super.key,
    required this.child,
    this.onPressed,
    this.blur = 12,
    this.opacity = 0.2,
    this.borderRadius = 16,
    this.animationDuration = const Duration(milliseconds: 180),
    this.animate = true,
    this.border,
    this.shadow,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.semanticsLabel,
    this.semanticsOnTapHint,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final double blur;
  final double opacity;
  final double borderRadius;
  final Duration animationDuration;
  final bool animate;
  final Border? border;
  final List<BoxShadow>? shadow;
  final EdgeInsets padding;

  /// Optional semantic label (defaults to "Glass button").
  final String? semanticsLabel;

  /// Optional semantic onTap hint (defaults to "Activate" when onPressed is provided).
  final String? semanticsOnTapHint;

  @override
  State<GlassMorphButton> createState() => _GlassMorphButtonState();
}

class _GlassMorphButtonState extends State<GlassMorphButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!mounted) return;
    setState(() => _pressed = value);
  }

  double get _scale => _pressed ? 0.96 : 1.0;
  double get _currentBlur => _pressed ? widget.blur * 0.6 : widget.blur;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // Respect user preference for reduced motion and accessible navigation.
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;
    final highContrast = mq.highContrast;

    final duration = reduceMotion ? Duration.zero : widget.animationDuration;
    final radius = BorderRadius.circular(widget.borderRadius);

    // If high contrast is requested and no border provided, add a prominent border.
    final effectiveBorder = widget.border ??
        (highContrast
            ? Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.9),
                width: 2.0,
              )
            : null);

    Widget content = AnimatedScale(
      scale: widget.animate ? _scale : 1.0,
      duration: duration,
      curve: Curves.easeOut,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surface
              .withValues(alpha: widget.opacity),
          borderRadius: radius,
          border: effectiveBorder,
          boxShadow: widget.shadow,
        ),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.labelLarge ?? const TextStyle(),
          child: Center(child: widget.child),
        ),
      ),
    );

    // Apply blur via BackdropFilter inside a clipped container.
    content = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _currentBlur,
          sigmaY: _currentBlur,
        ),
        child: content,
      ),
    );

    // Gesture handling with accessible semantics.
    return Semantics(
      label: widget.semanticsLabel ?? 'Glass button',
      button: true,
      onTapHint: widget.semanticsOnTapHint ??
          (widget.onPressed != null ? 'Activate' : null),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) {
          _setPressed(false);
          widget.onPressed?.call();
        },
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeOut,
          // Small elevation change when pressed — visual polish only.
          transform: Matrix4.identity()
            ..translateByVector3(Vector3(0.0, _pressed ? 1.0 : 0.0, 0.0)),
          child: content,
        ),
      ),
    );
  }
}
