import 'package:flutter/material.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withValues(alpha: 0.1),
              colorScheme.secondary.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section
                GlassMorphCard(
                  elevation: 8,
                  borderRadius: 24,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.blur_on,
                          size: 48,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Glass Morph Widgets',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Beautiful animated glass-morphism widgets for Flutter',
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Widget Showcase Section
                Text(
                  'Widget Showcase',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 24),

                // GlassMorphButton Showcase
                _buildWidgetSection(
                  context,
                  title: 'GlassMorphButton',
                  description: 'Animated button with glass-morphism effect',
                  child: GlassMorphButton(
                    onPressed: () {},
                    blur: 12,
                    opacity: 0.2,
                    borderRadius: 16,
                    animate: true,
                    child: Text(
                      'Tap Me!',
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // GlassMorphCard Showcase
                _buildWidgetSection(
                  context,
                  title: 'GlassMorphCard',
                  description: 'Card with glass-morphism background',
                  child: GlassMorphCard(
                    elevation: 4,
                    borderRadius: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(
                            Icons.card_giftcard,
                            color: colorScheme.primary,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sample Card',
                            style: TextStyle(
                              fontSize: 18,
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // GlassMorphFloatingActionButton Showcase
                _buildWidgetSection(
                  context,
                  title: 'GlassMorphFloatingActionButton',
                  description: 'Floating action button with glass effect',
                  child: GlassMorphFloatingActionButton(
                    onPressed: () {},
                    blur: 12,
                    opacity: 0.2,
                    child: Icon(
                      Icons.add,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // GlassMorphAppBar Showcase
                _buildWidgetSection(
                  context,
                  title: 'GlassMorphAppBar',
                  description:
                      'App bar with glass-morphism effect and backdrop blur',
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: colorScheme.surface.withValues(alpha: 0.1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GlassMorphAppBar(
                        title: Text(
                          'Glass Morph App Bar',
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        blur: 12,
                        opacity: 0.2,
                        actions: [
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: colorScheme.onSurface,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: colorScheme.onSurface,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // GlassMorphBottomSheet Showcase
                _buildWidgetSection(
                  context,
                  title: 'GlassMorphBottomSheet',
                  description: 'Modal bottom sheet with glass-morphism effect',
                  child: GlassMorphButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => GlassMorphBottomSheet(
                          blur: 12,
                          opacity: 0.2,
                          borderRadius: 16,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Glass Morph Bottom Sheet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'This is a glass-morphism bottom sheet with animated blur effects.',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                GlassMorphButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  blur: 8,
                                  opacity: 0.15,
                                  borderRadius: 12,
                                  child: Text(
                                    'Close',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    blur: 12,
                    opacity: 0.2,
                    borderRadius: 16,
                    child: Text(
                      'Show Bottom Sheet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // GlassMorphDialog Showcase
                _buildWidgetSection(
                  context,
                  title: 'GlassMorphDialog',
                  description: 'Modal dialog with glass-morphism effect',
                  child: GlassMorphButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => GlassMorphDialog(
                          blur: 12,
                          opacity: 0.2,
                          borderRadius: 16,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.help,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Glass Morph Dialog',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'This is a glass-morphism dialog with animated blur effects and accessibility support.',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: GlassMorphButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        blur: 8,
                                        opacity: 0.15,
                                        borderRadius: 12,
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: GlassMorphButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        blur: 8,
                                        opacity: 0.15,
                                        borderRadius: 12,
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    blur: 12,
                    opacity: 0.2,
                    borderRadius: 16,
                    child: Text(
                      'Show Dialog',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                const SizedBox(height: 32),

                // Gradient Backgrounds Showcase Section
                Text(
                  'Gradient Backgrounds',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 24),

                // Ocean Gradient Showcase
                _buildWidgetSection(
                  context,
                  title: 'Ocean Gradient',
                  description:
                      'Glass-morphism with ocean-inspired gradient background',
                  child: GlassMorphButton(
                    onPressed: () {},
                    blur: 12,
                    opacity: 0.2,
                    borderRadius: 16,
                    animate: true,
                    gradientConfig: GlassGradientConfig.ocean,
                    child: Text(
                      'Ocean',
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Stats Section
                // Stats Section
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        icon: Icons.download,
                        title: 'Downloads',
                        value: '1K+',
                        color: colorScheme.primary,
                        textTheme: textTheme,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        icon: Icons.star,
                        title: 'Rating',
                        value: '4.8',
                        color: colorScheme.secondary,
                        textTheme: textTheme,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        icon: Icons.devices,
                        title: 'Platforms',
                        value: 'All',
                        color: colorScheme.tertiary,
                        textTheme: textTheme,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        icon: Icons.code,
                        title: 'Pure Dart',
                        value: 'Yes',
                        color: colorScheme.primary,
                        textTheme: textTheme,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetSection(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GlassMorphCard(
      elevation: 4,
      borderRadius: 16,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            Center(child: child),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required TextTheme textTheme,
  }) {
    return GlassMorphCard(
      elevation: 4,
      borderRadius: 16,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                value,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                title,
                style: textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
