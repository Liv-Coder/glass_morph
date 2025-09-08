import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'utils/glass_gradient_config.dart';

/// A glass-morphism bottom sheet with slide animations and drag-to-dismiss functionality.
///
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   builder: (context) => GlassMorphBottomSheet(
///     child: Column(
///       mainAxisSize: MainAxisSize.min,
///       children: [
///         ListTile(title: Text('Option 1')),
///         ListTile(title: Text('Option 2')),
///       ],
///     ),
///   ),
/// );
/// ```
class GlassMorphBottomSheet extends StatefulWidget {
  /// Creates a glass-morphism bottom sheet.
  const GlassMorphBottomSheet({
    super.key,
    required this.child,
    this.blur = 12,
    this.opacity = 0.2,
    this.borderRadius = 16,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableDrag = true,
    this.isDismissible = true,
    this.onDismiss,
    this.semanticsLabel,
    this.semanticsHint,
    this.border,
    this.shadow,
    this.gradientConfig,
    this.padding = const EdgeInsets.all(16),
  })  : assert(blur >= 0, 'Blur value must be non-negative'),
        assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');

  /// The content to display inside the bottom sheet.
  final Widget child;

  /// The blur intensity for the glass effect (sigma value).
  final double blur;

  /// The opacity of the background tint.
  final double opacity;

  /// The border radius of the bottom sheet corners.
  final double borderRadius;

  /// The duration of slide animations.
  final Duration animationDuration;

  /// Whether to enable drag-to-dismiss functionality.
  final bool enableDrag;

  /// Whether the bottom sheet can be dismissed by tapping outside.
  final bool isDismissible;

  /// Callback when the bottom sheet is dismissed.
  final VoidCallback? onDismiss;

  /// Optional semantic label for accessibility.
  final String? semanticsLabel;

  /// Optional semantic hint for accessibility.
  final String? semanticsHint;

  /// Optional border for the bottom sheet.
  final Border? border;

  /// Optional shadow for the bottom sheet.
  final List<BoxShadow>? shadow;

  /// Optional gradient configuration for background effects.
  /// When provided, replaces the solid color background with a gradient.
  final GlassGradientConfig? gradientConfig;

  /// Padding around the child content.
  final EdgeInsets padding;

  @override
  State<GlassMorphBottomSheet> createState() => _GlassMorphBottomSheetState();
}

class _GlassMorphBottomSheetState extends State<GlassMorphBottomSheet>
    with SingleTickerProviderStateMixin {
  /// Clamped blur value to prevent performance issues (max 50 sigma)
  double get _clampedBlur => widget.blur.clamp(0.0, 50.0);
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  double _dragOffset = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Start the slide-in animation (respect reduce motion)
    final mq = MediaQuery.of(context);
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;
    if (!reduceMotion) {
      _animationController.forward();
    } else {
      // Skip animation and go directly to end state
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (!widget.enableDrag) return;
    _isDragging = true;
    _dragOffset = 0.0;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.enableDrag || !_isDragging) return;

    _dragOffset += details.delta.dy;
    if (_dragOffset < 0) _dragOffset = 0; // Prevent dragging up

    // Update the animation based on drag
    final progress = (_dragOffset / (MediaQuery.of(context).size.height * 0.3))
        .clamp(0.0, 1.0);
    _animationController.value = 1.0 - progress;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.enableDrag || !_isDragging) return;
    _isDragging = false;

    final mq = MediaQuery.of(context);
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;

    final velocity = details.velocity.pixelsPerSecond.dy;
    final shouldDismiss = _dragOffset > 100 || velocity > 500;

    if (shouldDismiss) {
      _dismiss();
    } else {
      // Snap back to original position (respect reduce motion)
      if (!reduceMotion) {
        _animationController.forward();
      } else {
        // Skip animation and go directly to start state
        _animationController.value = 1.0;
      }
      _dragOffset = 0.0;
    }
  }

  void _dismiss() {
    final mq = MediaQuery.of(context);
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;

    if (!reduceMotion) {
      _animationController.reverse().then((_) {
        widget.onDismiss?.call();
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } else {
      // Skip animation and dismiss immediately
      widget.onDismiss?.call();
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Color get backgroundColor {
    final theme = Theme.of(context);
    return theme.colorScheme.surface.withValues(alpha: widget.opacity);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final highContrast = mq.highContrast;

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

    final radius =
        BorderRadius.vertical(top: Radius.circular(widget.borderRadius));

    Widget content = Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.gradientConfig == null ? backgroundColor : null,
        gradient: widget.gradientConfig?.gradient,
        borderRadius: radius,
        border: effectiveBorder,
        boxShadow: widget.shadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
      ),
      child: widget.child,
    );

    // Apply glass effect
    content = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _clampedBlur,
          sigmaY: _clampedBlur,
        ),
        child: content,
      ),
    );

    // Add drag gesture detector
    if (widget.enableDrag) {
      content = GestureDetector(
        onVerticalDragStart: _handleDragStart,
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        child: content,
      );
    }

    // Apply slide animation
    content = SlideTransition(
      position: _slideAnimation,
      child: content,
    );

    // Add dismissible barrier
    if (widget.isDismissible) {
      content = Stack(
        children: [
          // Backdrop barrier
          Positioned.fill(
            child: GestureDetector(
              onTap: _dismiss,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Bottom sheet content
          Align(
            alignment: Alignment.bottomCenter,
            child: content,
          ),
        ],
      );
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Glass bottom sheet',
      hint: widget.semanticsHint ?? 'Swipe down to dismiss',
      container: true,
      child: content,
    );
  }
}

/// Convenience function to show a glass-morphism bottom sheet.
///
/// Usage:
/// ```dart
/// await showGlassMorphBottomSheet(
///   context: context,
///   builder: (context) => GlassMorphBottomSheet(...),
/// );
/// ```
Future<T?> showGlassMorphBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
  Color? barrierColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.5),
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    builder: builder,
  );
}
