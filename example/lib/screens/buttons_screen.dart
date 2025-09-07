import 'package:example/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  int _tapCount = 0;
  bool _isLoading = false;
  bool _isDisabled = false;

  // Interactive demo controls
  double _interactiveBlur = 12.0;
  double _interactiveOpacity = 0.2;
  double _interactiveBorderRadius = 16.0;
  bool _interactiveAnimate = true;
  Duration _interactiveAnimationDuration = const Duration(milliseconds: 200);
  String _interactiveText = 'Interactive Button';
  bool _showCodePreview = false;
  bool _showAdvancedControls = false;

  void _handleTap() {
    setState(() {
      _tapCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Button tapped! Count: $_tapCount'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleAsyncTap() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate async operation
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Async operation completed!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Glass Morph Buttons',
          style: textTheme.titleLarge?.copyWith(
            color: colorTheme.onPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorTheme.onPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorTheme.surface,
              colorTheme.surface.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Interactive Button Demos',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorTheme.onSurface,
                ),
              ),
              SizedBox(height: AppDimensions.paddingSmall),
              Text(
                'Explore different GlassMorphButton variations and animations',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorTheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: AppDimensions.marginLarge),

              // Basic Button
              _buildSection(
                title: 'Basic Button',
                description: 'Simple button with default styling',
                child: Center(
                  child: GlassMorphButton(
                    onPressed: _handleTap,
                    child: const Text(
                      'Tap Me!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Custom Styling
              _buildSection(
                title: 'Custom Styling',
                description: 'Different blur, opacity, and border radius',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GlassMorphButton(
                          onPressed: _handleTap,
                          blur: 8,
                          opacity: 0.1,
                          borderRadius: 8,
                          child: const Text(
                            'Subtle',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GlassMorphButton(
                          onPressed: _handleTap,
                          blur: 20,
                          opacity: 0.3,
                          borderRadius: 24,
                          child: const Text(
                            'Strong',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GlassMorphButton(
                      onPressed: _handleTap,
                      blur: 15,
                      opacity: 0.25,
                      borderRadius: 32,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: const Text(
                        'Rounded & Padded',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // With Icons
              _buildSection(
                title: 'With Icons',
                description: 'Buttons with icons for better UX',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GlassMorphButton(
                          onPressed: _handleTap,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.favorite, color: Colors.white),
                              const SizedBox(width: 8),
                              const Text(
                                'Like',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GlassMorphButton(
                          onPressed: _handleTap,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Share',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.share, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GlassMorphButton(
                      onPressed: _handleTap,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.download, color: Colors.white),
                          const SizedBox(width: 12),
                          const Text(
                            'Download File',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Loading States
              _buildSection(
                title: 'Loading States',
                description: 'Buttons with loading indicators',
                child: Column(
                  children: [
                    GlassMorphButton(
                      onPressed: _isLoading ? null : _handleAsyncTap,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Async Action',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    const SizedBox(height: 16),
                    GlassMorphButton(
                      onPressed: _handleTap,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Refresh',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Disabled State
              _buildSection(
                title: 'Disabled State',
                description: 'How buttons look when disabled',
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Enable buttons:',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Switch(
                          value: !_isDisabled,
                          onChanged: (value) {
                            setState(() {
                              _isDisabled = !value;
                            });
                          },
                          activeThumbColor: Colors.white,
                          activeTrackColor: Colors.white30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GlassMorphButton(
                      onPressed: _isDisabled ? null : _handleTap,
                      child: Text(
                        _isDisabled ? 'Disabled' : 'Enabled',
                        style: TextStyle(
                          color: _isDisabled ? Colors.white38 : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Animation Controls
              _buildSection(
                title: 'Animation Controls',
                description: 'Control button animations and timing',
                child: Column(
                  children: [
                    GlassMorphButton(
                      onPressed: _handleTap,
                      animate: true,
                      animationDuration: const Duration(milliseconds: 150),
                      child: const Text(
                        'Fast Animation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GlassMorphButton(
                      onPressed: _handleTap,
                      animate: true,
                      animationDuration: const Duration(milliseconds: 500),
                      child: const Text(
                        'Slow Animation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GlassMorphButton(
                      onPressed: _handleTap,
                      animate: false,
                      child: const Text(
                        'No Animation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Tap Counter
              _buildSection(
                title: 'Tap Counter',
                description: 'See how many times buttons have been tapped',
                child: Column(
                  children: [
                    Text(
                      'Total Taps: $_tapCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GlassMorphButton(
                          onPressed: () {
                            setState(() {
                              _tapCount = 0;
                            });
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GlassMorphButton(
                          onPressed: _handleTap,
                          child: const Text(
                            'Tap to Count',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Interactive Demo Controls
              _buildSection(
                title: 'Interactive Demo',
                description: 'Customize button properties in real-time',
                child: Column(
                  children: [
                    // Blur Slider
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Blur: ${_interactiveBlur.toStringAsFixed(1)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Slider(
                            value: _interactiveBlur,
                            min: 0,
                            max: 30,
                            divisions: 30,
                            label: _interactiveBlur.toStringAsFixed(1),
                            onChanged: (value) {
                              setState(() {
                                _interactiveBlur = value;
                              });
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.white30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Opacity Slider
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Opacity: ${(_interactiveOpacity * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Slider(
                            value: _interactiveOpacity,
                            min: 0.0,
                            max: 1.0,
                            divisions: 20,
                            label:
                                '${(_interactiveOpacity * 100).toStringAsFixed(0)}%',
                            onChanged: (value) {
                              setState(() {
                                _interactiveOpacity = value;
                              });
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.white30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Border Radius Slider
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Border Radius: ${_interactiveBorderRadius.toStringAsFixed(0)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Slider(
                            value: _interactiveBorderRadius,
                            min: 0,
                            max: 50,
                            divisions: 50,
                            label: _interactiveBorderRadius.toStringAsFixed(0),
                            onChanged: (value) {
                              setState(() {
                                _interactiveBorderRadius = value;
                              });
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.white30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Text Input
                    TextField(
                      controller: TextEditingController(text: _interactiveText),
                      onChanged: (value) {
                        setState(() {
                          _interactiveText = value;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Button Text',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Animation Controls
                    Row(
                      children: [
                        const Text(
                          'Animation: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Switch(
                          value: _interactiveAnimate,
                          onChanged: (value) {
                            setState(() {
                              _interactiveAnimate = value;
                            });
                          },
                          activeThumbColor: Colors.white,
                          activeTrackColor: Colors.white30,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Advanced: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Switch(
                          value: _showAdvancedControls,
                          onChanged: (value) {
                            setState(() {
                              _showAdvancedControls = value;
                            });
                          },
                          activeThumbColor: Colors.white,
                          activeTrackColor: Colors.white30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Live Preview Button
                    Center(
                      child: GlassMorphButton(
                        onPressed: _handleTap,
                        blur: _interactiveBlur,
                        opacity: _interactiveOpacity,
                        borderRadius: _interactiveBorderRadius,
                        animate: _interactiveAnimate,
                        animationDuration: _interactiveAnimationDuration,
                        child: Text(
                          _interactiveText.isEmpty
                              ? 'Interactive Button'
                              : _interactiveText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Code Preview Toggle
                    Row(
                      children: [
                        const Text(
                          'Show Code: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Switch(
                          value: _showCodePreview,
                          onChanged: (value) {
                            setState(() {
                              _showCodePreview = value;
                            });
                          },
                          activeThumbColor: Colors.white,
                          activeTrackColor: Colors.white30,
                        ),
                      ],
                    ),

                    // Code Preview
                    if (_showCodePreview) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Generated Code:',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _generateCodePreview(),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.copy,
                                      color: Colors.white70),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: _generateCodePreview()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Code copied to clipboard!'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  tooltip: 'Copy to clipboard',
                                ),
                                const Text(
                                  'Copy to clipboard',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  String _generateCodePreview() {
    final text =
        _interactiveText.isEmpty ? 'Interactive Button' : _interactiveText;
    final buffer = StringBuffer();

    buffer.writeln('GlassMorphButton(');
    buffer.writeln('  onPressed: () {},');
    buffer.writeln('  blur: ${_interactiveBlur.toStringAsFixed(1)},');
    buffer.writeln('  opacity: ${_interactiveOpacity.toStringAsFixed(2)},');
    buffer.writeln(
        '  borderRadius: ${_interactiveBorderRadius.toStringAsFixed(0)},');
    buffer.writeln('  animate: $_interactiveAnimate,');
    if (_interactiveAnimate) {
      buffer.writeln(
          '  animationDuration: const Duration(milliseconds: ${_interactiveAnimationDuration.inMilliseconds}),');
    }
    buffer.writeln('  child: const Text(');
    buffer.writeln('    \'$text\',');
    buffer.writeln('    style: TextStyle(');
    buffer.writeln('      color: Colors.white,');
    buffer.writeln('      fontSize: 16,');
    buffer.writeln('      fontWeight: FontWeight.w600,');
    buffer.writeln('    ),');
    buffer.writeln('  ),');
    buffer.writeln(')');

    return buffer.toString();
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
