import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'preview_photo_event.dart';
import 'preview_photo_state.dart';

class PreviewPhotoBloc extends Bloc<PreviewPhotoEvent, PreviewPhotoState> {
  PreviewPhotoBloc() : super(PreviewPhotoInitial()) {
    on<InitEvent>(_init);
    on<ApplyEvent>(_apply);
    on<DenyEvent>(_deny);

    add(InitEvent());
  }

  Future<void> _init(PreviewPhotoEvent event, Emitter<PreviewPhotoState> emit) async {
    //Todo: add event
    emit(PreviewPhotoInitial());
  }

  Future<void> _apply(ApplyEvent event, Emitter<PreviewPhotoState> emit) async {
    emit(ApplyState());
  }

  Future<void> _deny(DenyEvent event, Emitter<PreviewPhotoState> emit) async {
    emit(DenyState());
  }
}
