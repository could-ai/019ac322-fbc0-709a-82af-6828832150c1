import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/editor');
              },
              icon: const Icon(Icons.add),
              label: const Text('New Project'),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_open, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'No projects yet.',
              style: TextStyle(fontSize: 22, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              'Click "New Project" to start transcribing your first video.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
