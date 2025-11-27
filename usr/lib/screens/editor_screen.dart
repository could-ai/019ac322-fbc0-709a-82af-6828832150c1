import 'package:flutter/material.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subtitle Editor'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.translate),
            label: const Text('Translate'),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.cleaning_services),
            label: const Text('Clean Text'),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.timer),
            label: const Text('Timing Tools'),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Show export dialog
            },
            icon: const Icon(Icons.download),
            label: const Text('Export'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // Left Side: Video Player
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_outline, color: Colors.white, size: 100),
                    SizedBox(height: 20),
                    Text('Video Player Area', style: TextStyle(color: Colors.white, fontSize: 24)),
                  ],
                ),
              ),
            ),
          ),
          // Right Side: Subtitle Editor
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surface,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(Icons.edit_note, size: 80, color: Colors.grey),
                     SizedBox(height: 20),
                     Text(
                      'Subtitle blocks will appear here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
