class VideoRecordingInfo {
  final bool isRecording;
  final int durationMax;
  final int durationMin;
  final int actualRecordingDuration;
  final int? startedRecordingAt;

  const VideoRecordingInfo({
    this.isRecording = false,
    this.durationMax = 180,
    this.durationMin = 0,
    this.actualRecordingDuration = 0,
    this.startedRecordingAt,
  });

  VideoRecordingInfo copyWith({
    bool? isRecording,
    int? durationMax,
    int? durationMin,
    int? actualRecordingDuration,
    int? startedRecordingAt,
  }) {
    return VideoRecordingInfo(
      isRecording: isRecording ?? this.isRecording,
      durationMax: durationMax ?? this.durationMax,
      durationMin: durationMin ?? this.durationMin,
      actualRecordingDuration:
          actualRecordingDuration ?? this.actualRecordingDuration,
      startedRecordingAt: startedRecordingAt ?? this.startedRecordingAt,
    );
  }
}
