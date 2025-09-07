import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

/// A lightweight glass-morphism card surface.
/// Non-interactive by default; provide [onTap] to make it tappable.
class GlassMorphCard extends StatelessWidget {
  const GlassMorphCard({
    super.key,
    required this.child,
    this.onTap,
    this.blur = 12,
    this.opacity = 0.15,
    this.borderRadius = 12,
    this.elevation = 0,
    this.margin = EdgeInsets.zero,
    this.clipBehavior = Clip.none,
    this.border,
    this.shadow,
    this.semanticsLabel,
    this.semanticsOnTapHint,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double blur;
  final double opacity;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final Clip clipBehavior;
  final Border? border;
  final List<BoxShadow>? shadow;
  final String? semanticsLabel;
  final String? semanticsOnTapHint;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;
    final highContrast = mq.highContrast;

    final duration =
        reduceMotion ? Duration.zero : const Duration(milliseconds: 180);
    final radius = BorderRadius.circular(borderRadius);

    final effectiveBorder = border ??
        (highContrast
            ? Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.9),
                width: 2.0,
              )
            : null);

    Widget content = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        borderRadius: radius,
        border: effectiveBorder,
        boxShadow: shadow,
      ),
      child: child,
    );

    // Blur the background behind the card.
    content = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: content,
      ),
    );

    // Wrap with InkWell if interactive.
    if (onTap != null) {
      content = InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: content,
      );
    }

    final card = AnimatedContainer(
      duration: duration,
      child: Material(
        type: MaterialType.transparency,
        elevation: elevation,
        clipBehavior: clipBehavior,
        shape: RoundedRectangleBorder(borderRadius: radius),
        child: Padding(
          padding: margin,
          child: content,
        ),
      ),
    );

    return Semantics(
      label: semanticsLabel ?? 'Glass card',
      onTapHint: semanticsOnTapHint,
      container: true,
      child: card,
    );
  }
}
