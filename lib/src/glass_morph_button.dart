import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

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
    final duration = widget.animationDuration;
    final radius = BorderRadius.circular(widget.borderRadius);

    Widget content = AnimatedScale(
      scale: widget.animate ? _scale : 1.0,
      duration: duration,
      curve: Curves.easeOut,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(widget.opacity),
          borderRadius: radius,
          border: widget.border,
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

    // Gesture handling
    return Semantics(
      button: true,
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
          transform: Matrix4.identity()..translate(0.0, _pressed ? 1.0 : 0.0),
          child: content,
        ),
      ),
    );
  }
}
