import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('CouldAI Subtitler', style: TextStyle(color: theme.colorScheme.onPrimary)),
        backgroundColor: theme.primaryColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
            child: Text('Login', style: TextStyle(color: theme.colorScheme.onPrimary)),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
            child: const Text('Sign Up'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
            )
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildWorkflowSection(context),
            _buildFeaturesGrid(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
      ),
      child: Column(
        children: [
          Text(
            'Effortless Subtitles & Translations for MENA Creators',
            textAlign: TextAlign.center,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 24),
          Text(
            'Upload your video, and we’ll handle the transcription, subtitling, and translation with cutting-edge AI. Fast, accurate, and built for your workflow.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 40),
          _buildUploadBox(context),
        ],
      ),
    );
  }

  Widget _buildUploadBox(BuildContext context) {
    return Container(
      width: 600,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.cloud_upload_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Drag & drop your video file here',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'or paste a video link',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.video_library_outlined),
            label: const Text('Choose a File'),
            onPressed: () {
              // TODO: Implement file picking logic
              Navigator.pushNamed(context, '/editor');
            },
          ),
          const SizedBox(height: 16),
          const Text('Supports: MP4, MOV, WebM, MKV', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildWorkflowSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
      child: Column(
        children: [
          Text('How It Works', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WorkflowStep(icon: Icons.upload_file, title: '1. Upload', description: 'Drop a video file or paste a link.'),
              _WorkflowStep(icon: Icons.transform, title: '2. Transcribe', description: 'AI generates accurate subtitles.'),
              _WorkflowStep(icon: Icons.edit, title: '3. Edit & Translate', description: 'Fine-tune text and translate.'),
              _WorkflowStep(icon: Icons.download, title: '4. Export', description: 'Get SRT, VTT, or burned-in video.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
      child: Column(
        children: [
          Text('Powerful Features for a Seamless Workflow', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 40),
          const Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _FeatureCard(icon: Icons.translate, title: 'MENA Language Focus', description: 'Specialized AI for Arabic, Kurdish, Turkish, Persian, Hebrew, and more.'),
              _FeatureCard(icon: Icons.edit_document, title: 'Intuitive Subtitle Editor', description: 'Easily split, merge, and time-sync your subtitles with a live preview.'),
              _FeatureCard(icon: Icons.rocket_launch, title: 'Multiple Export Options', description: 'Export to SRT, VTT, TXT, or get a video with burned-in subtitles.'),
              _FeatureCard(icon: Icons.high_quality, title: 'High-Accuracy AI', description: 'Leverage state-of-the-art transcription for precise results.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Theme.of(context).primaryColor,
      child: const Text('© 2024 CouldAI Subtitler. All Rights Reserved.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
    );
  }
}

class _WorkflowStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _WorkflowStep({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
         boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
