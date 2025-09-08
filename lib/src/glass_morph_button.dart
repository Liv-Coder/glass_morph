import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:flutter/services.dart';
import 'utils/glass_gradient_config.dart';
import 'utils/glass_variant_config.dart';

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
    this.gradientConfig,
    this.variantConfig,
    this.semanticsLabel,
    this.semanticsOnTapHint,
  })  : assert(blur >= 0, 'Blur value must be non-negative'),
        assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');

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

  /// Optional gradient configuration for background effects.
  /// When provided, replaces the solid color background with a gradient.
  final GlassGradientConfig? gradientConfig;

  /// Optional variant configuration for different widget styles.
  /// When provided, overrides the default glass morphism behavior.
  final GlassVariantConfig? variantConfig;

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
  double get _currentBlur {
    final baseBlur =
        widget.variantConfig?.getEffectiveBlur(widget.blur) ?? widget.blur;
    return _pressed ? baseBlur * 0.6 : baseBlur;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // Respect user preference for reduced motion and accessible navigation.
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;
    final highContrast = mq.highContrast;

    final duration = reduceMotion ? Duration.zero : widget.animationDuration;
    final radius = BorderRadius.circular(widget.borderRadius);

    // Apply variant configuration if provided
    final effectiveOpacity =
        widget.variantConfig?.getEffectiveOpacity(widget.opacity) ??
            widget.opacity;
    final effectiveBorderRadius = widget.borderRadius;
    final effectiveBorder = widget.variantConfig?.border ??
        widget.border ??
        (highContrast
            ? Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.9),
                width: 2.0,
              )
            : null);
    final effectiveShadow = widget.shadow;
    final effectivePadding = widget.padding;

    Widget content = AnimatedScale(
      scale: widget.animate ? _scale : 1.0,
      duration: duration,
      curve: Curves.easeOut,
      child: Container(
        padding: effectivePadding,
        decoration: BoxDecoration(
          gradient: widget.gradientConfig?.toGradient(),
          color: widget.gradientConfig == null
              ? Theme.of(context)
                  .colorScheme
                  .surface
                  .withValues(alpha: effectiveOpacity)
              : null,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          border: effectiveBorder,
          boxShadow: effectiveShadow,
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
    // Generate more descriptive semantic label based on content
    String generateSemanticLabel() {
      if (widget.semanticsLabel != null) return widget.semanticsLabel!;

      // Try to extract text from child widget for better context
      String contentDescription = 'Glass button';
      if (widget.child is Text) {
        final textContent = (widget.child as Text).data ?? '';
        if (textContent.isNotEmpty) {
          contentDescription = '$textContent button';
        }
      }

      return contentDescription;
    }

    return Semantics(
      label: generateSemanticLabel(),
      button: true,
      enabled: widget.onPressed != null,
      onTapHint: widget.semanticsOnTapHint ??
          (widget.onPressed != null ? 'Tap to activate' : null),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) {
          _setPressed(false);
          HapticFeedback.lightImpact();
          widget.onPressed?.call();
        },
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeOut,
          // Small elevation change when pressed — visual polish only.
          transform: Matrix4.translationValues(0.0, _pressed ? 1.0 : 0.0, 0.0),
          child: content,
        ),
      ),
    );
  }
}
