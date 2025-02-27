import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'compressing_video_event.dart';

part 'compressing_video_state.dart';

class CompressingVideoBloc
    extends Bloc<CompressingVideoEvent, CompressingVideoState> {
  CompressingVideoBloc() : super(CompressingVideoState()) {
    on<UpdateProgressEvent>(_onUpdateProgressEvent);
    on<VideoCompressedEvent>(_onVideoCompressedEvent);
  }

  void _onUpdateProgressEvent(UpdateProgressEvent event, Emitter emit) {
    emit(state.copyWith(percents: event.progress));
  }

  void _onVideoCompressedEvent(_, Emitter<CompressingVideoState> emit) {
    emit(state.copyWith(
      percents: 0,
      compressingVideoIndex: state.compressingVideoIndex + 1,
    ));
  }
}
