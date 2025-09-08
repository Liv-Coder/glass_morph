import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:flutter/services.dart';
import 'utils/glass_gradient_config.dart';

/// GlassMorphFloatingActionButton: glass FAB with accessible semantics, highContrast and reduceMotion.
class GlassMorphFloatingActionButton extends StatefulWidget {
  const GlassMorphFloatingActionButton({
    super.key,
    required this.child,
    this.onPressed,
    this.blur = 12,
    this.opacity = 0.16,
    this.size = 56,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 180),
    this.gradientConfig,
    this.semanticsLabel,
    this.semanticsOnTapHint,
  })  : assert(blur >= 0, 'Blur value must be non-negative'),
        assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');

  final Widget child;
  final VoidCallback? onPressed;
  final double blur;
  final double opacity;
  final double size;
  final bool animate;
  final Duration animationDuration;
  final GlassGradientConfig? gradientConfig;
  final String? semanticsLabel;
  final String? semanticsOnTapHint;

  @override
  State<GlassMorphFloatingActionButton> createState() =>
      _GlassMorphFloatingActionButtonState();
}

class _GlassMorphFloatingActionButtonState
    extends State<GlassMorphFloatingActionButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (!mounted) return;
    setState(() => _pressed = v);
  }

  double get _scale => _pressed ? 0.92 : 1.0;
  double get _currentBlur => _pressed ? widget.blur * 0.6 : widget.blur;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;
    final highContrast = mq.highContrast;
    final theme = Theme.of(context);

    final duration = reduceMotion ? Duration.zero : widget.animationDuration;
    final size = widget.size;
    final effectiveBorder = highContrast
        ? Border.all(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
            width: 2.0,
          )
        : null;

    // Theme-aware background color for glass morphism effect
    final backgroundColor =
        theme.colorScheme.surface.withValues(alpha: widget.opacity);

    Widget content = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: widget.gradientConfig == null ? backgroundColor : null,
        gradient: widget.gradientConfig?.gradient,
        shape: BoxShape.circle,
        border: effectiveBorder,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Center(child: widget.child),
    );

    content = ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _currentBlur, sigmaY: _currentBlur),
        child: content,
      ),
    );

    if (widget.onPressed != null) {
      content = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) {
          _setPressed(false);
          HapticFeedback.lightImpact();
          widget.onPressed?.call();
        },
        child: AnimatedScale(
          scale: widget.animate ? _scale : 1.0,
          duration: duration,
          curve: Curves.easeOut,
          child: content,
        ),
      );
    } else {
      content = AnimatedScale(
        scale: 1.0,
        duration: duration,
        child: content,
      );
    }

    // Generate more descriptive semantic label based on content
    String generateSemanticLabel() {
      if (widget.semanticsLabel != null) return widget.semanticsLabel!;

      // Try to extract text from child widget for better context
      String contentDescription = 'Glass floating action button';
      if (widget.child is Text) {
        final textContent = (widget.child as Text).data ?? '';
        if (textContent.isNotEmpty) {
          contentDescription = '$textContent button';
        }
      } else if (widget.child is Icon) {
        // For icon-only FABs, provide more context
        contentDescription = 'Glass action button';
      }

      return contentDescription;
    }

    return Semantics(
      container: true,
      button: true,
      enabled: widget.onPressed != null,
      label: generateSemanticLabel(),
      onTapHint: widget.semanticsOnTapHint ??
          (widget.onPressed != null ? 'Tap to perform action' : null),
      child: Material(
        type: MaterialType.transparency,
        child: content,
      ),
    );
  }
}
