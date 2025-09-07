import 'package:example/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';
import '../theme/theme.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  bool _showBorder = true;
  double _elevation = 4.0;
  double _blur = 12.0;
  double _opacity = 0.2;

  void _toggleBorder() {
    setState(() {
      _showBorder = !_showBorder;
    });
  }

  void _updateElevation(double value) {
    setState(() {
      _elevation = value;
    });
  }

  void _updateBlur(double value) {
    setState(() {
      _blur = value;
    });
  }

  void _updateOpacity(double value) {
    setState(() {
      _opacity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Glass Morph Cards',
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
                'Interactive Card Demos',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorTheme.onSurface,
                ),
              ),
              SizedBox(height: AppDimensions.paddingSmall),
              Text(
                'Explore different GlassMorphCard layouts and configurations',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorTheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: AppDimensions.marginLarge),

              // Controls Section
              _buildSection(
                title: 'Card Controls',
                description: 'Adjust card properties in real-time',
                child: GlassMorphCard(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Border Toggle
                        Row(
                          children: [
                            const Text(
                              'Show Border:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const Spacer(),
                            Switch(
                              value: _showBorder,
                              onChanged: (value) => _toggleBorder(),
                              activeThumbColor: Colors.white,
                              activeTrackColor: Colors.white30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Elevation Slider
                        Row(
                          children: [
                            const Text(
                              'Elevation:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _elevation.toStringAsFixed(1),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Slider(
                          value: _elevation,
                          min: 0,
                          max: 20,
                          divisions: 20,
                          onChanged: _updateElevation,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white30,
                        ),

                        // Blur Slider
                        Row(
                          children: [
                            const Text(
                              'Blur:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _blur.toStringAsFixed(1),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Slider(
                          value: _blur,
                          min: 0,
                          max: 30,
                          divisions: 30,
                          onChanged: _updateBlur,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white30,
                        ),

                        // Opacity Slider
                        Row(
                          children: [
                            const Text(
                              'Opacity:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              (_opacity * 100).toStringAsFixed(0) + '%',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Slider(
                          value: _opacity,
                          min: 0.0,
                          max: 0.5,
                          divisions: 50,
                          onChanged: _updateOpacity,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Live Preview
              _buildSection(
                title: 'Live Preview',
                description: 'See your changes applied to a card',
                child: GlassMorphCard(
                  elevation: _elevation,
                  blur: _blur,
                  opacity: _opacity,
                  border: _showBorder
                      ? Border.all(color: Colors.white24, width: 1)
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Icon(
                          Icons.preview,
                          color: Colors.white,
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Preview Card',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'This card reflects your current settings',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Content Layouts
              _buildSection(
                title: 'Content Layouts',
                description: 'Different ways to arrange content in cards',
                child: Column(
                  children: [
                    // Simple Text Card
                    GlassMorphCard(
                      elevation: 4,
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Simple text content with glass-morphism effect. This demonstrates the basic card layout with centered text.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Icon + Text Card
                    GlassMorphCard(
                      elevation: 4,
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Information Card',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Cards can contain icons, titles, and descriptions in various layouts.',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Action Card
                    GlassMorphCard(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.touch_app,
                              color: Colors.white,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Interactive Card',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Tap the button below to see the card in action',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            GlassMorphButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Card action triggered!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Text(
                                'Tap Me',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Card Grid
              _buildSection(
                title: 'Card Grid Layout',
                description: 'Multiple cards arranged in a responsive grid',
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildGridCard(
                      icon: Icons.photo,
                      title: 'Gallery',
                      description: 'View images',
                    ),
                    _buildGridCard(
                      icon: Icons.music_note,
                      title: 'Music',
                      description: 'Play songs',
                    ),
                    _buildGridCard(
                      icon: Icons.video_library,
                      title: 'Videos',
                      description: 'Watch content',
                    ),
                    _buildGridCard(
                      icon: Icons.settings,
                      title: 'Settings',
                      description: 'App preferences',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Elevation Variations
              _buildSection(
                title: 'Elevation Variations',
                description: 'Different shadow depths for visual hierarchy',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildElevationCard(2, 'Low'),
                        _buildElevationCard(8, 'Medium'),
                        _buildElevationCard(16, 'High'),
                      ],
                    ),
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

  Widget _buildGridCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return GlassMorphCard(
      elevation: 4,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tapped: $title'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElevationCard(double elevation, String label) {
    return Column(
      children: [
        GlassMorphCard(
          elevation: elevation,
          child: const SizedBox(
            width: 80,
            height: 80,
            child: Icon(
              Icons.layers,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
