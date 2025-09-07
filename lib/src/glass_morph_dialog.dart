import 'dart:ui';

import 'package:flutter/material.dart';

/// A glass-morphism dialog widget with animated blur effects and accessibility support.
///
/// This widget provides a modal dialog with glass-morphism styling, featuring:
/// - Animated blur and opacity effects
/// - Configurable border radius and padding
/// - Accessibility support with Semantics
/// - High contrast mode support
/// - Reduced motion support
/// - Dismissible functionality (tap outside to close)
/// - Optional close button
///
/// Example usage:
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => GlassMorphDialog(
///     blur: 12,
///     opacity: 0.2,
///     borderRadius: 16,
///     child: Column(
///       mainAxisSize: MainAxisSize.min,
///       children: [
///         Text('Dialog Title'),
///         SizedBox(height: 16),
///         Text('Dialog content...'),
///       ],
///     ),
///   ),
/// );
/// ```
class GlassMorphDialog extends StatefulWidget {
  /// The child widget to display inside the dialog.
  final Widget child;

  /// The blur sigma value for the glass effect. Default is 12.
  final double blur;

  /// The background opacity for the glass effect. Default is 0.2.
  final double opacity;

  /// The border radius of the dialog. Default is 16.
  final double borderRadius;

  /// The padding inside the dialog. Default is EdgeInsets.all(24).
  final EdgeInsets padding;

  /// The margin around the dialog. Default is EdgeInsets.symmetric(horizontal: 40, vertical: 24).
  final EdgeInsets margin;

  /// The border of the dialog. Default is null.
  final Border? border;

  /// The box shadows for the dialog. Default is null.
  final List<BoxShadow>? shadow;

  /// The duration of the animation. Default is 200ms.
  final Duration animationDuration;

  /// Whether to animate the dialog appearance. Default is true.
  final bool animate;

  /// Whether the dialog can be dismissed by tapping outside. Default is true.
  final bool isDismissible;

  /// Whether to show a close button. Default is false.
  final bool showCloseButton;

  /// The callback when the dialog is dismissed.
  final VoidCallback? onDismissed;

  /// The semantic label for accessibility.
  final String? semanticLabel;

  /// The semantic hint for accessibility.
  final String? semanticHint;

  const GlassMorphDialog({
    super.key,
    required this.child,
    this.blur = 12,
    this.opacity = 0.2,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(24),
    this.margin = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    this.border,
    this.shadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animate = true,
    this.isDismissible = true,
    this.showCloseButton = false,
    this.onDismissed,
    this.semanticLabel,
    this.semanticHint,
  });

  @override
  State<GlassMorphDialog> createState() => _GlassMorphDialogState();
}

class _GlassMorphDialogState extends State<GlassMorphDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.animate ? 0.8 : 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _opacityAnimation = Tween<double>(
      begin: widget.animate ? 0.0 : 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    if (widget.animate) {
      _animationController.forward();
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDismiss() {
    if (widget.animate) {
      _animationController.reverse().then((_) {
        widget.onDismissed?.call();
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } else {
      widget.onDismissed?.call();
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Color get backgroundColor {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return isLight
        ? Colors.black.withValues(alpha: widget.opacity)
        : Colors.white.withValues(alpha: widget.opacity);
  }

  @override
  Widget build(BuildContext context) {
    final highContrast = MediaQuery.highContrastOf(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    // Adjust opacity for high contrast mode
    final adjustedOpacity =
        highContrast ? widget.opacity.clamp(0.0, 0.1) : widget.opacity;

    return PopScope(
      canPop: widget.isDismissible,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && widget.animate) {
          _animationController.reverse();
        }
      },
      child: GestureDetector(
        onTap: widget.isDismissible ? _handleDismiss : null,
        child: Container(
          color: Colors.black.withValues(alpha: 0.5),
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevent tap from bubbling up
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: reduceMotion ? 1.0 : _scaleAnimation.value,
                    child: Opacity(
                      opacity: reduceMotion ? 1.0 : _opacityAnimation.value,
                      child: Container(
                        margin: widget.margin,
                        child: Semantics(
                          label: widget.semanticLabel,
                          hint: widget.semanticHint,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(widget.borderRadius),
                              border: widget.border,
                              boxShadow: widget.shadow,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(widget.borderRadius),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: widget.blur,
                                  sigmaY: widget.blur,
                                ),
                                child: Container(
                                  color: backgroundColor.withValues(
                                      alpha: adjustedOpacity),
                                  padding: widget.padding,
                                  child: Stack(
                                    children: [
                                      widget.child,
                                      if (widget.showCloseButton)
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Semantics(
                                            label: 'Close dialog',
                                            hint: 'Tap to close this dialog',
                                            button: true,
                                            child: IconButton(
                                              onPressed: _handleDismiss,
                                              icon: const Icon(Icons.close),
                                              iconSize: 24,
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(
                                                minWidth: 32,
                                                minHeight: 32,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
