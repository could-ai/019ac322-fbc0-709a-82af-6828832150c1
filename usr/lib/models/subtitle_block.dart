class SubtitleBlock {
  String id;
  Duration startTime;
  Duration endTime;
  String text;
  String? speaker;
  bool isSelected;

  SubtitleBlock({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.text,
    this.speaker,
    this.isSelected = false,
  });

  SubtitleBlock copyWith({
    String? id,
    Duration? startTime,
    Duration? endTime,
    String? text,
    String? speaker,
    bool? isSelected,
  }) {
    return SubtitleBlock(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      text: text ?? this.text,
      speaker: speaker ?? this.speaker,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
