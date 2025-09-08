import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'utils/glass_gradient_config.dart';

/// GlassMorphAppBar: glass-morphism app bar with accessible semantics, highContrast and reduceMotion.
class GlassMorphAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassMorphAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.blur = 12,
    this.opacity = 0.15,
    this.animationDuration = const Duration(milliseconds: 180),
    this.border,
    this.shadow,
    this.gradientConfig,
    this.semanticsLabel,
    this.semanticsOnTapHint,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight = kToolbarHeight,
    this.bottom,
  })  : assert(blur >= 0, 'Blur value must be non-negative'),
        assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final double? titleSpacing;
  final double toolbarHeight;
  final PreferredSizeWidget? bottom;

  // Glass-morphism parameters
  final double blur;
  final double opacity;
  final Duration animationDuration;
  final Border? border;
  final List<BoxShadow>? shadow;
  final GlassGradientConfig? gradientConfig;
  final String? semanticsLabel;
  final String? semanticsOnTapHint;

  /// Clamped blur value to prevent performance issues (max 50 sigma)
  double get _clampedBlur => blur.clamp(0.0, 50.0);

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final reduceMotion = mq.disableAnimations || mq.accessibleNavigation;
    final highContrast = mq.highContrast;
    final theme = Theme.of(context);

    final duration = reduceMotion ? Duration.zero : animationDuration;

    final effectiveBorder = border ??
        (highContrast
            ? Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.9),
                width: 1.0,
              )
            : null);

    // Theme-aware background color for glass morphism effect
    final backgroundColor =
        theme.colorScheme.surface.withValues(alpha: opacity);

    Widget appBarContent = Container(
      height: toolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: gradientConfig == null ? backgroundColor : null,
        gradient: gradientConfig?.gradient,
        border: effectiveBorder,
        boxShadow: shadow,
      ),
      child: Row(
        children: [
          if (leading != null) leading!,
          if (leading != null) const SizedBox(width: 16),
          Expanded(
            child: title != null
                ? DefaultTextStyle(
                    style: theme.appBarTheme.titleTextStyle ??
                        theme.textTheme.titleLarge ??
                        const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                    child: title!,
                  )
                : const SizedBox(),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );

    // Apply blur effect to the background
    appBarContent = ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _clampedBlur, sigmaY: _clampedBlur),
        child: appBarContent,
      ),
    );

    // Wrap in AnimatedContainer for smooth transitions
    final animatedAppBar = AnimatedContainer(
      duration: duration,
      height: toolbarHeight,
      child: appBarContent,
    );

    // Combine app bar with bottom widget if present
    Widget result = animatedAppBar;
    if (bottom != null) {
      result = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          animatedAppBar,
          bottom!,
        ],
      );
    }

    // Generate more descriptive semantic label based on content
    String generateSemanticLabel() {
      if (semanticsLabel != null) return semanticsLabel!;

      // Try to extract title text for better context
      String contentDescription = 'Glass app bar';
      if (title is Text) {
        final titleText = (title as Text).data ?? '';
        if (titleText.isNotEmpty) {
          contentDescription = 'App bar with $titleText';
        }
      }

      return contentDescription;
    }

    return Semantics(
      container: true,
      label: generateSemanticLabel(),
      onTapHint: semanticsOnTapHint,
      child: result,
    );
  }
}
