import 'package:example/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';
import '../theme/theme.dart';

class DialogsScreen extends StatefulWidget {
  const DialogsScreen({super.key});

  @override
  State<DialogsScreen> createState() => _DialogsScreenState();
}

class _DialogsScreenState extends State<DialogsScreen> {
  void _showBasicDialog() {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (context) => GlassMorphDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Basic Dialog',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorTheme.onSurface,
              ),
            ),
            SizedBox(height: AppDimensions.paddingMedium),
            Text(
              'This is a basic glass-morphism dialog with simple content and actions.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorTheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: colorTheme.onSurface),
                  ),
                ),
                SizedBox(width: AppDimensions.paddingSmall),
                GlassMorphButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: TextStyle(color: colorTheme.onSurface),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (context) => GlassMorphDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Confirm Action',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorTheme.onSurface,
              ),
            ),
            SizedBox(height: AppDimensions.paddingMedium),
            Text(
              'Are you sure you want to proceed with this action?',
              style: TextStyle(
                color: colorTheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingSmall),
            Text(
              'This action cannot be undone.',
              style: TextStyle(
                fontSize: 12,
                color: colorTheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: colorTheme.onSurface),
                  ),
                ),
                SizedBox(width: AppDimensions.paddingSmall),
                GlassMorphButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Action confirmed!')),
                    );
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomDialog() {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (context) => GlassMorphDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: colorTheme.secondary),
                SizedBox(width: AppDimensions.paddingSmall),
                Text(
                  'Custom Dialog',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorTheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingMedium),
            Text(
              'This dialog has custom styling and content.',
              style: TextStyle(
                color: colorTheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMedium),
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingMedium),
              decoration: BoxDecoration(
                color: colorTheme.surface.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadiusMedium),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: colorTheme.primary),
                  SizedBox(width: AppDimensions.paddingSmall),
                  Expanded(
                    child: Text(
                      'Additional information can be displayed here.',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorTheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style: TextStyle(color: colorTheme.onSurface),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFormDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => GlassMorphDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter Information',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Please enter your name:',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Your name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white10,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                GlassMorphButton(
                  onPressed: () {
                    final name = controller.text.trim();
                    Navigator.pop(context);
                    if (name.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hello, $name!')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GlassMorphDialog(
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Please wait while we process your request...'),
          ],
        ),
      ),
    );

    // Simulate processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing completed!')),
        );
      }
    });
  }

  void _showLargeDialog() {
    showDialog(
      context: context,
      builder: (context) => GlassMorphDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Large Content Dialog',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'This dialog contains a lot of content that requires scrolling.',
                      style: TextStyle(height: 1.5, color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Features demonstrated:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    ...[
                      '• Glass-morphism effect',
                      '• Scrollable content',
                      '• Multiple action buttons',
                      '• Custom styling',
                      '• Accessibility support',
                      '• Responsive design',
                    ].map((feature) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(feature,
                              style: const TextStyle(color: Colors.white70)),
                        )),
                    const SizedBox(height: 16),
                    const Text(
                      'The dialog automatically handles content overflow and provides a smooth user experience across all platforms.',
                      style: TextStyle(height: 1.5, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                const SizedBox(width: 8),
                GlassMorphButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Got it'),
                ),
              ],
            ),
          ],
        ),
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
          'Glass Morph Dialogs',
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
                'Dialog Demonstrations',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorTheme.onSurface,
                ),
              ),
              SizedBox(height: AppDimensions.paddingSmall),
              Text(
                'Explore different GlassMorphDialog configurations and use cases',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorTheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: AppDimensions.marginLarge),

              // Basic Dialogs
              _buildSection(
                title: 'Basic Dialogs',
                description: 'Simple dialogs with standard content and actions',
                child: Column(
                  children: [
                    _buildDialogButton(
                      'Basic Dialog',
                      'Simple dialog with title, content, and actions',
                      _showBasicDialog,
                    ),
                    const SizedBox(height: 16),
                    _buildDialogButton(
                      'Confirmation Dialog',
                      'Dialog for confirming user actions',
                      _showConfirmationDialog,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Custom Dialogs
              _buildSection(
                title: 'Custom Dialogs',
                description: 'Dialogs with custom styling and complex content',
                child: Column(
                  children: [
                    _buildDialogButton(
                      'Custom Styled Dialog',
                      'Dialog with icons and custom content layout',
                      _showCustomDialog,
                    ),
                    const SizedBox(height: 16),
                    _buildDialogButton(
                      'Form Dialog',
                      'Dialog containing form inputs',
                      _showFormDialog,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Special Dialogs
              _buildSection(
                title: 'Special Dialogs',
                description: 'Dialogs for specific use cases and scenarios',
                child: Column(
                  children: [
                    _buildDialogButton(
                      'Progress Dialog',
                      'Non-dismissible dialog with loading indicator',
                      _showProgressDialog,
                    ),
                    const SizedBox(height: 16),
                    _buildDialogButton(
                      'Large Content Dialog',
                      'Dialog with scrollable content',
                      _showLargeDialog,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Dialog Features
              _buildSection(
                title: 'Dialog Features',
                description:
                    'Key features and capabilities of GlassMorphDialog',
                child: GlassMorphCard(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFeatureItem(
                          Icons.blur_on,
                          'Glass Morphism',
                          'Beautiful blur effects with customizable opacity',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          Icons.animation,
                          'Smooth Animations',
                          'Fade in/out and scale animations for better UX',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          Icons.touch_app,
                          'Dismissible',
                          'Tap outside to dismiss (configurable)',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          Icons.accessibility,
                          'Accessibility',
                          'Screen reader support and semantic labels',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          Icons.devices,
                          'Cross-Platform',
                          'Works on mobile, web, and desktop',
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

  Widget _buildDialogButton(
    String title,
    String description,
    VoidCallback onPressed,
  ) {
    return GlassMorphCard(
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
