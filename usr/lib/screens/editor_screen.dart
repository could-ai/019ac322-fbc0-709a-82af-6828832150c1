import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/subtitle_block.dart';
import 'dart:async';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  // Mock Data
  List<SubtitleBlock> _subtitles = [];
  Duration _currentPosition = const Duration(seconds: 0);
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    _subtitles = [
      SubtitleBlock(
        id: '1',
        startTime: const Duration(seconds: 0),
        endTime: const Duration(seconds: 3),
        text: "Welcome to the future of video editing.",
        speaker: "Speaker 1",
      ),
      SubtitleBlock(
        id: '2',
        startTime: const Duration(seconds: 3, milliseconds: 500),
        endTime: const Duration(seconds: 7),
        text: "With CouldAI, you can transcribe and translate in seconds.",
        speaker: "Speaker 1",
      ),
      SubtitleBlock(
        id: '3',
        startTime: const Duration(seconds: 8),
        endTime: const Duration(seconds: 12),
        text: "مرحباً بكم في مستقبل تحرير الفيديو. مع CouldAI، يمكنك النسخ والترجمة في ثوانٍ.",
        speaker: "Speaker 2",
      ),
      SubtitleBlock(
        id: '4',
        startTime: const Duration(seconds: 13),
        endTime: const Duration(seconds: 16),
        text: "Just upload your video and let our AI handle the rest.",
        speaker: "Speaker 1",
      ),
    ];
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    // Mock playback
    if (_isPlaying) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!_isPlaying) {
          timer.cancel();
        } else {
          setState(() {
            _currentPosition += const Duration(seconds: 1);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subtitle Editor'),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: () {},
            tooltip: 'Save Project',
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              // Show export dialog
            },
            icon: const Icon(Icons.download),
            label: const Text('Export'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Top Toolbar
          _buildToolbar(theme),
          
          // Main Workspace
          Expanded(
            child: Row(
              children: [
                // Left: Video Player & Timeline
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildVideoPlayer(context),
                      ),
                      _buildTimelineControls(theme),
                      SizedBox(
                        height: 120,
                        child: _buildWaveformTimeline(theme),
                      ),
                    ],
                  ),
                ),
                
                // Right: Subtitle List
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.grey.shade300)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        _buildSubtitleListHeader(theme),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(0),
                            itemCount: _subtitles.length,
                            itemBuilder: (context, index) {
                              return _buildSubtitleItem(context, index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(ThemeData theme) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          _ToolbarButton(icon: Icons.translate, label: 'Translate', onPressed: () {}),
          _ToolbarButton(icon: Icons.cleaning_services_outlined, label: 'Clean Text', onPressed: () {}),
          const VerticalDivider(indent: 12, endIndent: 12),
          _ToolbarButton(icon: Icons.find_replace, label: 'Find & Replace', onPressed: () {}),
          _ToolbarButton(icon: Icons.merge_type, label: 'Merge', onPressed: () {}),
          _ToolbarButton(icon: Icons.call_split, label: 'Split', onPressed: () {}),
          const VerticalDivider(indent: 12, endIndent: 12),
          _ToolbarButton(icon: Icons.format_size, label: 'Styles', onPressed: () {}),
          const Spacer(),
          Text(
            'Auto-save: On',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Placeholder for actual video
          const Center(
            child: Text(
              'Video Preview',
              style: TextStyle(color: Colors.white54, fontSize: 20),
            ),
          ),
          // Overlay Controls
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _formatDuration(_currentPosition),
                style: const TextStyle(color: Colors.white, fontFamily: 'Monospace'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineControls(ThemeData theme) {
    return Container(
      height: 50,
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: () {},
            tooltip: 'Previous Subtitle',
          ),
          IconButton(
            icon: const Icon(Icons.replay_5),
            onPressed: () {},
            tooltip: 'Back 5s',
          ),
          const SizedBox(width: 16),
          FloatingActionButton.small(
            onPressed: _togglePlayPause,
            backgroundColor: theme.primaryColor,
            child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.forward_5),
            onPressed: () {},
            tooltip: 'Forward 5s',
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: () {},
            tooltip: 'Next Subtitle',
          ),
          const Spacer(),
          // Speed Control
          PopupMenuButton<double>(
            initialValue: _playbackSpeed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('${_playbackSpeed}x'),
            ),
            onSelected: (speed) {
              setState(() => _playbackSpeed = speed);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 0.5, child: Text('0.5x')),
              const PopupMenuItem(value: 1.0, child: Text('1.0x')),
              const PopupMenuItem(value: 1.5, child: Text('1.5x')),
              const PopupMenuItem(value: 2.0, child: Text('2.0x')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaveformTimeline(ThemeData theme) {
    return Container(
      color: Colors.grey.shade900,
      width: double.infinity,
      child: Stack(
        children: [
          // Mock Waveform
          Positioned.fill(
            child: CustomPaint(
              painter: WaveformPainter(),
            ),
          ),
          // Playhead
          Center(
            child: Container(
              width: 2,
              color: theme.colorScheme.secondary,
            ),
          ),
          // Time markers
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 20,
              color: Colors.black26,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('00:00', style: TextStyle(color: Colors.white54, fontSize: 10)),
                  Text('00:15', style: TextStyle(color: Colors.white54, fontSize: 10)),
                  Text('00:30', style: TextStyle(color: Colors.white54, fontSize: 10)),
                  Text('00:45', style: TextStyle(color: Colors.white54, fontSize: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitleListHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          const SizedBox(width: 40, child: Text('#', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
          const SizedBox(width: 80, child: Text('Start', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
          const SizedBox(width: 80, child: Text('End', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
          const Expanded(child: Text('Subtitle Text', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: theme.primaryColor,
            onPressed: () {
              // Add new subtitle
            },
            tooltip: 'Add Subtitle',
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitleItem(BuildContext context, int index) {
    final block = _subtitles[index];
    final isSelected = block.isSelected;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.05) : Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Index
          SizedBox(
            width: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('${index + 1}', style: const TextStyle(color: Colors.grey)),
            ),
          ),
          
          // Timing
          Column(
            children: [
              _TimeInput(time: block.startTime),
              const SizedBox(height: 4),
              _TimeInput(time: block.endTime),
            ],
          ),
          const SizedBox(width: 16),
          
          // Text Input
          Expanded(
            child: TextField(
              controller: TextEditingController(text: block.text),
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.all(12),
                hintText: 'Enter subtitle text...',
              ),
              style: const TextStyle(fontSize: 14),
              onTap: () {
                setState(() {
                  for (var s in _subtitles) {
                    s.isSelected = false;
                  }
                  block.isSelected = true;
                });
              },
            ),
          ),
          
          // Actions
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    _subtitles.removeAt(index);
                  });
                },
              ),
              if (index < _subtitles.length - 1)
                IconButton(
                  icon: const Icon(Icons.merge_type, size: 20, color: Colors.grey),
                  onPressed: () {
                    // Merge logic
                  },
                  tooltip: 'Merge with next',
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ToolbarButton({required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18, color: Colors.grey.shade700),
        label: Text(label, style: TextStyle(color: Colors.grey.shade700)),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}

class _TimeInput extends StatelessWidget {
  final Duration time;

  const _TimeInput({required this.time});

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String ms = (time.inMilliseconds % 1000).toString().padLeft(3, "0");
    String text = "${twoDigits(time.inMinutes.remainder(60))}:${twoDigits(time.inSeconds.remainder(60))}.$ms";

    return SizedBox(
      width: 80,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 12, fontFamily: 'Monospace'),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final random = [0.4, 0.6, 0.3, 0.8, 0.5, 0.9, 0.2, 0.7, 0.4, 0.6, 0.3, 0.8, 0.5, 0.9, 0.2, 0.7, 0.4, 0.6, 0.3, 0.8, 0.5, 0.9, 0.2, 0.7];
    
    final barWidth = size.width / 100;
    
    for (int i = 0; i < 100; i++) {
      final height = size.height * random[i % random.length] * 0.8;
      final x = i * barWidth;
      final y = (size.height - height) / 2;
      
      canvas.drawLine(
        Offset(x, size.height / 2 - height / 2),
        Offset(x, size.height / 2 + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
