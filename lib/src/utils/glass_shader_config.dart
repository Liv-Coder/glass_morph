import 'dart:ui' as ui;
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

/// Configuration class for shader-based glass morphism effects.
/// Provides advanced visual effects using FragmentShader when available.
class GlassShaderConfig {
  const GlassShaderConfig({
    this.blurSigma = 12.0,
    this.opacity = 0.2,
    this.noiseIntensity = 0.1,
    this.reflectionStrength = 0.3,
    this.distortionAmount = 0.05,
    this.enableShader = true,
    this.fallbackToBackdropFilter = true,
  });

  final double blurSigma;
  final double opacity;
  final double noiseIntensity;
  final double reflectionStrength;
  final double distortionAmount;
  final bool enableShader;
  final bool fallbackToBackdropFilter;

  GlassShaderConfig copyWith({
    double? blurSigma,
    double? opacity,
    double? noiseIntensity,
    double? reflectionStrength,
    double? distortionAmount,
    bool? enableShader,
    bool? fallbackToBackdropFilter,
  }) {
    return GlassShaderConfig(
      blurSigma: blurSigma ?? this.blurSigma,
      opacity: opacity ?? this.opacity,
      noiseIntensity: noiseIntensity ?? this.noiseIntensity,
      reflectionStrength: reflectionStrength ?? this.reflectionStrength,
      distortionAmount: distortionAmount ?? this.distortionAmount,
      enableShader: enableShader ?? this.enableShader,
      fallbackToBackdropFilter:
          fallbackToBackdropFilter ?? this.fallbackToBackdropFilter,
    );
  }

  /// Preset configurations for different glass styles
  static const GlassShaderConfig minimal = GlassShaderConfig(
    blurSigma: 8.0,
    opacity: 0.15,
    noiseIntensity: 0.05,
    reflectionStrength: 0.2,
    distortionAmount: 0.02,
  );

  static const GlassShaderConfig elegant = GlassShaderConfig(
    blurSigma: 12.0,
    opacity: 0.25,
    noiseIntensity: 0.08,
    reflectionStrength: 0.4,
    distortionAmount: 0.03,
  );

  static const GlassShaderConfig bold = GlassShaderConfig(
    blurSigma: 16.0,
    opacity: 0.3,
    noiseIntensity: 0.12,
    reflectionStrength: 0.5,
    distortionAmount: 0.05,
  );

  static const GlassShaderConfig frosted = GlassShaderConfig(
    blurSigma: 20.0,
    opacity: 0.35,
    noiseIntensity: 0.15,
    reflectionStrength: 0.6,
    distortionAmount: 0.08,
  );
}

/// Utility class for managing shader-based glass effects.
/// Handles shader compilation, caching, and fallback mechanisms.
class GlassShaderManager {
  static final GlassShaderManager _instance = GlassShaderManager._internal();
  factory GlassShaderManager() => _instance;
  GlassShaderManager._internal();

  /// Cache for compiled shaders
  final Map<String, ui.FragmentShader> _shaderCache = {};

  /// Check if FragmentShader is supported on current platform
  bool get isShaderSupported {
    // FragmentShader is available in Flutter 3.13+ with Impeller
    // For now, we'll use a version check as a proxy
    return true; // Will be refined based on actual platform capabilities
  }

  /// Get or create a shader for glass morphism effects
  Future<ui.FragmentShader?> getGlassShader(String shaderKey) async {
    if (!isShaderSupported) return null;

    if (_shaderCache.containsKey(shaderKey)) {
      return _shaderCache[shaderKey];
    }

    try {
      // TODO: Implement actual shader loading from assets
      // For now, return null to use fallback
      return null;
    } catch (e) {
      debugPrint('Failed to load glass shader: $e');
      return null;
    }
  }

  /// Clear shader cache
  void clearCache() {
    _shaderCache.clear();
  }

  /// Preload commonly used shaders
  Future<void> preloadShaders() async {
    // TODO: Implement shader preloading
  }
}

/// Shader-based glass morphism painter.
/// Uses FragmentShader for advanced visual effects when available.
class ShaderGlassPainter extends CustomPainter {
  const ShaderGlassPainter({
    required this.config,
    required this.borderRadius,
    this.shader,
  });

  final GlassShaderConfig config;
  final BorderRadius borderRadius;
  final ui.FragmentShader? shader;

  @override
  void paint(Canvas canvas, Size size) {
    if (shader != null && GlassShaderManager().isShaderSupported) {
      _paintWithShader(canvas, size);
    } else {
      _paintFallback(canvas, size);
    }
  }

  void _paintWithShader(Canvas canvas, Size size) {
    // TODO: Implement shader-based painting
    // This will use the FragmentShader for advanced effects
  }

  void _paintFallback(Canvas canvas, Size size) {
    // Fallback to traditional BackdropFilter approach
    final paint = Paint()
      ..color = Colors.white.withOpacity(config.opacity)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant ShaderGlassPainter oldDelegate) {
    return oldDelegate.config != config ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.shader != shader;
  }
}

/// Extension methods for easy shader integration
extension GlassShaderExtensions on Widget {
  /// Apply shader-based glass morphism effect
  Widget withShaderGlass({
    required GlassShaderConfig config,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return ShaderGlassWidget(
      config: config,
      borderRadius: borderRadius,
      child: this,
    );
  }
}

/// Widget that applies shader-based glass morphism effects
class ShaderGlassWidget extends StatefulWidget {
  const ShaderGlassWidget({
    super.key,
    required this.child,
    required this.config,
    this.borderRadius = BorderRadius.zero,
  });

  final Widget child;
  final GlassShaderConfig config;
  final BorderRadius borderRadius;

  @override
  State<ShaderGlassWidget> createState() => _ShaderGlassWidgetState();
}

class _ShaderGlassWidgetState extends State<ShaderGlassWidget> {
  ui.FragmentShader? _shader;

  @override
  void initState() {
    super.initState();
    _loadShader();
  }

  @override
  void didUpdateWidget(ShaderGlassWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.enableShader != widget.config.enableShader) {
      _loadShader();
    }
  }

  Future<void> _loadShader() async {
    if (widget.config.enableShader) {
      _shader = await GlassShaderManager().getGlassShader('glass_morphism');
      if (mounted) setState(() {});
    } else {
      _shader = null;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.config.enableShader && _shader != null) {
      // Use shader-based approach
      return CustomPaint(
        painter: ShaderGlassPainter(
          config: widget.config,
          borderRadius: widget.borderRadius,
          shader: _shader,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.config.blurSigma,
              sigmaY: widget.config.blurSigma,
            ),
            child: widget.child,
          ),
        ),
      );
    } else if (widget.config.fallbackToBackdropFilter) {
      // Fallback to traditional BackdropFilter
      return ClipRRect(
        borderRadius: widget.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.config.blurSigma,
            sigmaY: widget.config.blurSigma,
          ),
          child: Container(
            color: Colors.white.withOpacity(widget.config.opacity),
            child: widget.child,
          ),
        ),
      );
    } else {
      // No effect
      return widget.child;
    }
  }
}
