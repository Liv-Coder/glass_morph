import 'package:flutter/material.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';

class BottomSheetsScreen extends StatefulWidget {
  const BottomSheetsScreen({super.key});

  @override
  State<BottomSheetsScreen> createState() => _BottomSheetsScreenState();
}

class _BottomSheetsScreenState extends State<BottomSheetsScreen> {
  double _blur = 12.0;
  double _opacity = 0.2;
  double _borderRadius = 16.0;

  void _showBasicBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => GlassMorphBottomSheet(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy Link'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Bookmark'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => GlassMorphBottomSheet(
        blur: _blur,
        opacity: _opacity,
        borderRadius: _borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Custom Glass Bottom Sheet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'This bottom sheet has custom glass morph properties that you can adjust using the controls above.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              GlassMorphButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFormBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => GlassMorphBottomSheet(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add New Item',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GlassMorphButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GlassMorphButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMediaBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => GlassMorphBottomSheet(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share Media',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.camera_alt, size: 30),
                      ),
                      const SizedBox(height: 8),
                      const Text('Camera', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.photo_library, size: 30),
                      ),
                      const SizedBox(height: 8),
                      const Text('Gallery', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.video_call, size: 30),
                      ),
                      const SizedBox(height: 8),
                      const Text('Video', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GlassMorphButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glass Morph Bottom Sheets'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Glass Morph Bottom Sheets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Animated bottom sheets with glass-morphism effects, drag-to-dismiss functionality, and accessibility support.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Customization Controls
            const Text(
              'Customization',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GlassMorphCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Blur:'),
                        Expanded(
                          child: Slider(
                            value: _blur,
                            min: 0,
                            max: 20,
                            onChanged: (value) => setState(() => _blur = value),
                          ),
                        ),
                        Text(_blur.toStringAsFixed(1)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Opacity:'),
                        Expanded(
                          child: Slider(
                            value: _opacity,
                            min: 0,
                            max: 0.5,
                            onChanged: (value) =>
                                setState(() => _opacity = value),
                          ),
                        ),
                        Text(_opacity.toStringAsFixed(2)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Border Radius:'),
                        Expanded(
                          child: Slider(
                            value: _borderRadius,
                            min: 0,
                            max: 32,
                            onChanged: (value) =>
                                setState(() => _borderRadius = value),
                          ),
                        ),
                        Text(_borderRadius.toStringAsFixed(0)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Examples
            const Text(
              'Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Basic Bottom Sheet
            GlassMorphButton(
              onPressed: _showBasicBottomSheet,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list),
                  SizedBox(width: 8),
                  Text('Basic Bottom Sheet'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Custom Bottom Sheet
            GlassMorphButton(
              onPressed: _showCustomBottomSheet,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.tune),
                  SizedBox(width: 8),
                  Text('Custom Properties'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Form Bottom Sheet
            GlassMorphButton(
              onPressed: _showFormBottomSheet,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Form Bottom Sheet'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Media Bottom Sheet
            GlassMorphButton(
              onPressed: _showMediaBottomSheet,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo),
                  SizedBox(width: 8),
                  Text('Media Bottom Sheet'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Usage Information
            const Text(
              'Usage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GlassMorphCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'showModalBottomSheet(',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                    Text(
                      '  context: context,',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                    Text(
                      '  builder: (context) => GlassMorphBottomSheet(',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                    Text(
                      '    child: YourContent(),',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                    Text(
                      '  ),',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                    Text(
                      ');',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
