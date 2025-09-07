import 'package:example/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';
import '../theme/theme.dart';

class FabScreen extends StatefulWidget {
  const FabScreen({super.key});

  @override
  State<FabScreen> createState() => _FabScreenState();
}

class _FabScreenState extends State<FabScreen> {
  bool _showSecondaryFab = false;
  double _fabSize = 56.0;
  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endFloat;

  void _toggleSecondaryFab() {
    setState(() {
      _showSecondaryFab = !_showSecondaryFab;
    });
  }

  void _updateFabSize(double value) {
    setState(() {
      _fabSize = value;
    });
  }

  void _changeFabLocation(FloatingActionButtonLocation location) {
    setState(() {
      _fabLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Glass Morph FABs',
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
                'Floating Action Button Demos',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorTheme.onSurface,
                ),
              ),
              SizedBox(height: AppDimensions.paddingSmall),
              Text(
                'Explore different GlassMorphFloatingActionButton configurations',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorTheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: AppDimensions.marginLarge),

              // Controls Section
              _buildSection(
                title: 'FAB Controls',
                description: 'Customize FAB appearance and behavior',
                child: GlassMorphCard(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Secondary FAB Toggle
                        Row(
                          children: [
                            const Text(
                              'Show Secondary FAB:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const Spacer(),
                            Switch(
                              value: _showSecondaryFab,
                              onChanged: (value) => _toggleSecondaryFab(),
                              activeThumbColor: Colors.white,
                              activeTrackColor: Colors.white30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Size Slider
                        Row(
                          children: [
                            const Text(
                              'Size:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _fabSize.toStringAsFixed(0),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Slider(
                          value: _fabSize,
                          min: 40,
                          max: 80,
                          divisions: 8,
                          onChanged: _updateFabSize,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white30,
                        ),

                        // Location Selector
                        const SizedBox(height: 16),
                        const Text(
                          'FAB Location:',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            _buildLocationButton(
                              'Bottom Right',
                              FloatingActionButtonLocation.endFloat,
                            ),
                            _buildLocationButton(
                              'Bottom Left',
                              FloatingActionButtonLocation.startFloat,
                            ),
                            _buildLocationButton(
                              'Top Right',
                              FloatingActionButtonLocation.endTop,
                            ),
                            _buildLocationButton(
                              'Top Left',
                              FloatingActionButtonLocation.startTop,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Basic FAB Examples
              _buildSection(
                title: 'Basic FAB Examples',
                description: 'Standard FAB configurations with different icons',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBasicFab(
                          icon: Icons.add,
                          onPressed: () => _showSnackBar('Add button pressed'),
                        ),
                        _buildBasicFab(
                          icon: Icons.edit,
                          onPressed: () => _showSnackBar('Edit button pressed'),
                        ),
                        _buildBasicFab(
                          icon: Icons.share,
                          onPressed: () =>
                              _showSnackBar('Share button pressed'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // FAB with Different Sizes
              _buildSection(
                title: 'Size Variations',
                description: 'FABs with different sizes for various use cases',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSizedFab(
                          icon: Icons.favorite,
                          size: 48,
                          onPressed: () => _showSnackBar('Small FAB pressed'),
                        ),
                        _buildSizedFab(
                          icon: Icons.camera,
                          size: 56,
                          onPressed: () => _showSnackBar('Medium FAB pressed'),
                        ),
                        _buildSizedFab(
                          icon: Icons.video_call,
                          size: 64,
                          onPressed: () => _showSnackBar('Large FAB pressed'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // FAB in Context
              _buildSection(
                title: 'FAB in Context',
                description: 'FABs positioned within content areas',
                child: GlassMorphCard(
                  elevation: 4,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        // Content
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Content Area',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'This card demonstrates how FABs can be positioned within content areas for contextual actions.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        // FAB positioned in card
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GlassMorphFloatingActionButton(
                            onPressed: () => _showSnackBar('Contextual action'),
                            child: const Icon(Icons.more_vert),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // FAB Animation Demo
              _buildSection(
                title: 'Animation Demo',
                description: 'See FAB animations in action',
                child: GlassMorphCard(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Tap the FAB below to see scale and blur animations',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GlassMorphFloatingActionButton(
                            onPressed: () =>
                                _showSnackBar('Animated FAB pressed!'),
                            child: const Icon(Icons.play_arrow),
                            animate: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),

      // Dynamic FAB based on controls
      floatingActionButton: _showSecondaryFab
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GlassMorphFloatingActionButton(
                  onPressed: () => _showSnackBar('Secondary FAB pressed'),
                  child: const Icon(Icons.star),
                ),
                const SizedBox(width: 16),
                GlassMorphFloatingActionButton(
                  onPressed: () => _showSnackBar('Primary FAB pressed'),
                  child: const Icon(Icons.add),
                ),
              ],
            )
          : GlassMorphFloatingActionButton(
              onPressed: () => _showSnackBar('Main FAB pressed'),
              child: const Icon(Icons.add),
            ),

      floatingActionButtonLocation: _fabLocation,
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

  Widget _buildLocationButton(
      String label, FloatingActionButtonLocation location) {
    return ElevatedButton(
      onPressed: () => _changeFabLocation(location),
      style: ElevatedButton.styleFrom(
        backgroundColor: _fabLocation == location
            ? Colors.white.withValues(alpha: 0.2)
            : Colors.transparent,
        foregroundColor: Colors.white,
        side: BorderSide(
          color: _fabLocation == location ? Colors.white : Colors.white30,
          width: 1,
        ),
      ),
      child: Text(label),
    );
  }

  Widget _buildBasicFab({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GlassMorphFloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }

  Widget _buildSizedFab({
    required IconData icon,
    required double size,
    required VoidCallback onPressed,
  }) {
    return GlassMorphFloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
      size: size,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
