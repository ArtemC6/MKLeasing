part of 'compressing_video_bloc.dart';

@immutable
abstract class CompressingVideoEvent {}

class UpdateProgressEvent extends CompressingVideoEvent {
  final double progress;

  UpdateProgressEvent({required this.progress});
}

class VideoCompressedEvent extends CompressingVideoEvent {}
