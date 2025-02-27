part of 'compressing_video_bloc.dart';

class CompressingVideoState {
  final double percents;
  final int compressingVideoIndex;

  CompressingVideoState({this.compressingVideoIndex = 0, this.percents = 0});

  CompressingVideoState copyWith({
    double? percents,
    int? compressingVideoIndex,
  }) {
    return CompressingVideoState(
      percents: percents ?? this.percents,
      compressingVideoIndex:
          compressingVideoIndex ?? this.compressingVideoIndex,
    );
  }
}
