import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

/// A glass-morphism FloatingActionButton replacement.
///
/// Usage:
/// ```dart
/// GlassMorphFAB(
///   onPressed: () {},
///   child: Icon(Icons.add),
/// )
/// ```
class GlassMorphFAB extends StatelessWidget {
  const GlassMorphFAB({
    super.key,
    required this.child,
    this.onPressed,
    this.blur = 12,
    this.opacity = 0.18,
    this.size = 56.0,
    this.animDuration = const Duration(milliseconds: 180),
    this.elevation = 6.0,
    this.border,
    this.shadow,
    this.tooltip,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final double blur;
  final double opacity;
  final double size;
  final Duration animDuration;
  final double elevation;
  final Border? border;
  final List<BoxShadow>? shadow;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(size / 2);

    Widget content = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((opacity.clamp(0.0, 1.0) * 255).round()),
        borderRadius: radius,
        border: border,
        boxShadow: shadow ??
            [
              BoxShadow(
                color: Colors.black12,
                blurRadius: elevation,
                offset: Offset(0, elevation / 2),
              ),
            ],
      ),
      child: Center(child: child),
    );

    content = ClipRRect(
      borderRadius: radius,
      child: RepaintBoundary(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: content,
        ),
      ),
    );

    // Ink / ripple + semantics + tooltip support
    Widget button = Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        customBorder: RoundedRectangleBorder(borderRadius: radius),
        child: SizedBox(width: size, height: size, child: content),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return Semantics(
      button: true,
      label: tooltip,
      child: AnimatedContainer(
        duration: animDuration,
        child: button,
      ),
    );
  }
}
