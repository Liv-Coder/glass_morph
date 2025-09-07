import 'package:flutter/material.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';
import '../theme/responsive_utils.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final String route;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

class GlassBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavigationItem> items;

  const GlassBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  State<GlassBottomNavigationBar> createState() =>
      _GlassBottomNavigationBarState();
}

class _GlassBottomNavigationBarState extends State<GlassBottomNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _opacityAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void didUpdateWidget(GlassBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _updateAnimations();
    }
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );

    _scaleAnimations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.1,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ));
    }).toList();

    _opacityAnimations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 0.7,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    // Start animation for current index
    if (widget.currentIndex < _animationControllers.length) {
      _animationControllers[widget.currentIndex].forward();
    }
  }

  void _updateAnimations() {
    // Reset all animations
    for (var controller in _animationControllers) {
      controller.reverse();
    }

    // Animate the new selected item
    if (widget.currentIndex < _animationControllers.length) {
      _animationControllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: context.responsivePadding * 0.5,
      child: GlassMorphCard(
        elevation: 8,
        borderRadius: context.responsiveBorderRadius(20),
        blur: context.responsiveBlur(15),
        opacity: context.responsiveOpacity(0.15),
        shadow: [
          BoxShadow(
            color: colorTheme.shadow.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        child: Container(
          padding: context.responsivePadding * 0.5,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(context.responsiveBorderRadius(20)),
            border: Border.all(
              color: colorTheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.items.length,
              (index) => _buildNavigationItem(
                context,
                index,
                colorTheme,
                textTheme,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(
    BuildContext context,
    int index,
    ColorScheme colorTheme,
    TextTheme textTheme,
  ) {
    final item = widget.items[index];
    final isSelected = index == widget.currentIndex;

    return Expanded(
      child: AnimatedBuilder(
        animation: _animationControllers[index],
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimations[index].value,
            child: Opacity(
              opacity: _opacityAnimations[index].value,
              child: InkWell(
                onTap: () => widget.onTap(index),
                borderRadius:
                    BorderRadius.circular(context.responsiveBorderRadius(16)),
                child: Container(
                  padding: context.responsivePadding * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        context.responsiveBorderRadius(16)),
                    color: isSelected
                        ? colorTheme.primaryContainer.withValues(alpha: 0.3)
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        color: isSelected
                            ? colorTheme.primary
                            : colorTheme.onSurface.withValues(alpha: 0.6),
                        size: context.responsiveSpacing(24),
                      ),
                      SizedBox(height: context.responsiveSpacing(4)),
                      ResponsiveText(
                        item.label,
                        style: textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? colorTheme.primary
                              : colorTheme.onSurface.withValues(alpha: 0.6),
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: context.responsiveSpacing(10),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
