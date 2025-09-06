import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

/// A glass-morphism Card widget with optional tap handling and elevation.
///
/// Designed to mirror the Button API where appropriate and remain pure-Dart / web-safe.
class GlassMorphCard extends StatelessWidget {
  const GlassMorphCard({
    super.key,
    required this.child,
    this.onTap,
    this.blur = 12,
    this.opacity = 0.2,
    this.borderRadius = 16,
    this.elevation = 4,
    this.margin = const EdgeInsets.all(8),
    this.clipBehavior = Clip.antiAlias,
    this.border,
    this.shadow,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double blur;
  final double opacity;
  final double borderRadius;
  final double elevation;
  final EdgeInsets margin;
  final Clip clipBehavior;
  final Border? border;
  final List<BoxShadow>? shadow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((opacity.clamp(0.0, 1.0) * 255).round()),
        borderRadius: radius,
        border: border,
        boxShadow: shadow,
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
        child: child,
      ),
    );

    content = ClipRRect(
      borderRadius: radius,
      clipBehavior: clipBehavior,
      child: RepaintBoundary(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blur,
            sigmaY: blur,
          ),
          child: content,
        ),
      ),
    );

    final decorated = Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: content,
      ),
    );

    return Padding(
      padding: margin,
      child: Semantics(
        container: true,
        button: onTap != null,
        label: child is Text ? (child as Text).data : null,
        child: decorated,
      ),
    );
  }
}
