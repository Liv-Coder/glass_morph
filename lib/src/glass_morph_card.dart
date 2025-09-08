import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:flutter/services.dart';
import 'utils/glass_gradient_config.dart';

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
    this.animationDuration = const Duration(milliseconds: 180),
    this.border,
    this.shadow,
    this.gradientConfig,
    this.semanticsLabel,
    this.semanticsOnTapHint,
  })  : assert(blur >= 0, 'Blur value must be non-negative'),
        assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');

  final Widget child;
  final VoidCallback? onTap;
  final double blur;
  final double opacity;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final Clip clipBehavior;
  final Duration animationDuration;
  final Border? border;
  final List<BoxShadow>? shadow;
  final GlassGradientConfig? gradientConfig;
  final String? semanticsLabel;
  final String? semanticsOnTapHint;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;
    final highContrast = mq.highContrast;
    final theme = Theme.of(context);

    final duration = reduceMotion ? Duration.zero : animationDuration;
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

    // Theme-aware background color for glass morphism effect
    final backgroundColor =
        theme.colorScheme.surface.withValues(alpha: opacity);

    Widget content = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: gradientConfig == null ? backgroundColor : null,
        gradient: gradientConfig?.gradient,
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
        onTap: () {
          HapticFeedback.lightImpact();
          onTap?.call();
        },
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

    // Generate more descriptive semantic label based on content
    String generateSemanticLabel() {
      if (semanticsLabel != null) return semanticsLabel!;

      // Try to extract meaningful content from child widget
      String contentDescription = 'Glass card';
      if (child is Text) {
        final textContent = (child as Text).data ?? '';
        if (textContent.isNotEmpty) {
          contentDescription = '$textContent card';
        }
      } else if (child is Column) {
        // Try to find a title-like text in the column
        final column = child as Column;
        for (final child in column.children) {
          if (child is Text) {
            final textContent = child.data ?? '';
            if (textContent.isNotEmpty && textContent.length < 50) {
              contentDescription = '$textContent card';
              break;
            }
          }
        }
      }

      return contentDescription;
    }

    return Semantics(
      label: generateSemanticLabel(),
      onTapHint:
          semanticsOnTapHint ?? (onTap != null ? 'Tap to interact' : null),
      container: true,
      child: card,
    );
  }
}
