import 'package:flutter/material.dart';

/// Responsive breakpoints following Material Design 3 guidelines
class ResponsiveBreakpoints {
  static const double mobile = 320;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double largeDesktop = 1440;
}

/// Extension methods for responsive design
extension ResponsiveContext on BuildContext {
  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if device is mobile
  bool get isMobile => screenWidth < ResponsiveBreakpoints.tablet;

  /// Check if device is tablet
  bool get isTablet =>
      screenWidth >= ResponsiveBreakpoints.tablet &&
      screenWidth < ResponsiveBreakpoints.desktop;

  /// Check if device is desktop
  bool get isDesktop => screenWidth >= ResponsiveBreakpoints.desktop;

  /// Check if device is large desktop
  bool get isLargeDesktop => screenWidth >= ResponsiveBreakpoints.largeDesktop;

  /// Get responsive padding
  EdgeInsets get responsivePadding {
    if (isMobile) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    } else if (isTablet) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    } else {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  /// Get responsive margin
  EdgeInsets get responsiveMargin {
    if (isMobile) {
      return const EdgeInsets.all(8);
    } else if (isTablet) {
      return const EdgeInsets.all(12);
    } else {
      return const EdgeInsets.all(16);
    }
  }

  /// Get responsive font size
  double responsiveFontSize(double baseSize) {
    if (isMobile) {
      return baseSize * 0.9;
    } else if (isTablet) {
      return baseSize;
    } else {
      return baseSize * 1.1;
    }
  }

  /// Get responsive spacing
  double responsiveSpacing(double baseSpacing) {
    if (isMobile) {
      return baseSpacing * 0.8;
    } else if (isTablet) {
      return baseSpacing;
    } else {
      return baseSpacing * 1.2;
    }
  }

  /// Get responsive border radius
  double responsiveBorderRadius(double baseRadius) {
    if (isMobile) {
      return baseRadius * 0.9;
    } else if (isTablet) {
      return baseRadius;
    } else {
      return baseRadius * 1.1;
    }
  }

  /// Get responsive blur value for glass morphism
  double responsiveBlur(double baseBlur) {
    if (isMobile) {
      return baseBlur * 0.8;
    } else if (isTablet) {
      return baseBlur;
    } else {
      return baseBlur * 1.2;
    }
  }

  /// Get responsive opacity for glass morphism
  double responsiveOpacity(double baseOpacity) {
    if (isMobile) {
      return baseOpacity * 1.1;
    } else if (isTablet) {
      return baseOpacity;
    } else {
      return baseOpacity * 0.9;
    }
  }

  /// Get responsive grid columns
  int get responsiveGridColumns {
    if (isMobile) {
      return 2;
    } else if (isTablet) {
      return 3;
    } else {
      return 4;
    }
  }

  /// Get responsive card size
  Size responsiveCardSize(double baseWidth, double baseHeight) {
    final width = responsiveSpacing(baseWidth);
    final height = responsiveSpacing(baseHeight);
    return Size(width, height);
  }

  /// Get responsive button size
  Size responsiveButtonSize(double baseWidth, double baseHeight) {
    final width = responsiveSpacing(baseWidth);
    final height = responsiveSpacing(baseHeight);
    return Size(width, height);
  }
}

/// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, bool isMobile, bool isTablet,
      bool isDesktop, bool isLargeDesktop) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;
    final isDesktop = context.isDesktop;
    final isLargeDesktop = context.isLargeDesktop;

    return builder(context, isMobile, isTablet, isDesktop, isLargeDesktop);
  }
}

/// Responsive layout widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isLargeDesktop && largeDesktop != null) {
      return largeDesktop!;
    } else if (context.isDesktop && desktop != null) {
      return desktop!;
    } else if (context.isTablet && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

/// Responsive grid view
class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final EdgeInsetsGeometry? padding;

  const ResponsiveGridView({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final columns = context.responsiveGridColumns;
    final responsiveSpacing = context.responsiveSpacing(spacing);
    final responsiveRunSpacing = context.responsiveSpacing(runSpacing);

    return GridView.count(
      crossAxisCount: columns,
      crossAxisSpacing: responsiveSpacing,
      mainAxisSpacing: responsiveRunSpacing,
      padding: padding ?? context.responsivePadding,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}

/// Responsive text widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = style?.fontSize != null
        ? context.responsiveFontSize(style!.fontSize!)
        : null;

    final responsiveStyle = style?.copyWith(
      fontSize: responsiveFontSize,
    );

    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive container with adaptive sizing
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final double? borderRadius;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveWidth =
        width != null ? context.responsiveSpacing(width!) : null;
    final responsiveHeight =
        height != null ? context.responsiveSpacing(height!) : null;
    final responsiveMargin = margin ?? context.responsiveMargin;
    final responsivePadding = padding ?? context.responsivePadding;
    final responsiveBorderRadius = borderRadius != null
        ? context.responsiveBorderRadius(borderRadius!)
        : null;

    final responsiveDecoration = decoration is BoxDecoration
        ? (decoration as BoxDecoration).copyWith(
            borderRadius: responsiveBorderRadius != null
                ? BorderRadius.circular(responsiveBorderRadius)
                : null,
          )
        : decoration;

    return Container(
      width: responsiveWidth,
      height: responsiveHeight,
      margin: responsiveMargin,
      padding: responsivePadding,
      decoration: responsiveDecoration,
      child: child,
    );
  }
}
