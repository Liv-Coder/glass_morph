import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

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
    this.semanticsLabel,
    this.semanticsOnTapHint,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final double blur;
  final double opacity;
  final double size;
  final bool animate;
  final Duration animationDuration;
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

    final duration = reduceMotion ? Duration.zero : widget.animationDuration;
    final size = widget.size;
    final effectiveBorder = highContrast
        ? Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
            width: 2.0,
          )
        : null;

    Widget content = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(widget.opacity),
        shape: BoxShape.circle,
        border: effectiveBorder,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
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

    return Semantics(
      container: true,
      button: true,
      label: widget.semanticsLabel ?? 'Glass floating action button',
      onTapHint: widget.semanticsOnTapHint ??
          (widget.onPressed != null ? 'Activate' : null),
      child: Material(
        type: MaterialType.transparency,
        child: content,
      ),
    );
  }
}
