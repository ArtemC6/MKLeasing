import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/camera_mode.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';
import 'package:video_player/video_player.dart';

part 'media_preview_page_event.dart';

part 'media_preview_page_state.dart';

class MediaPreviewPageBloc
    extends Bloc<MediaPreviewPageEvent, MediaPreviewPageState> {
  final List<MediaFileModel> mediaFiles;
  List<bool> contentOrientationsIsPortraitList = [];

  MediaPreviewPageBloc(int initialMediaFileIndex, this.mediaFiles)
      : super(MediaPreviewPageState(mediaFileIndex: initialMediaFileIndex)) {
    on<InitialEvent>(_onInitialEvent);
    on<HideAppBarAndCommentEvent>(_onHideAppBarAndCommentEvent);
    on<ShowAppBarAndCommentEvent>(_onShowAppBarAndCommentEvent);
    on<ChangedContentEvent>(_onChangedContentEvent);
    on<ChangedOrientationEvent>(_onChangedOrientationEvent);
    on<UpdateUiEvent>(_onUpdateUiEvent);
  }

  void _onShowAppBarAndCommentEvent(_, Emitter<MediaPreviewPageState> emit) {
    emit(state.copyWith(isPlayingVideoMode: false));
  }

  void _onHideAppBarAndCommentEvent(_, Emitter<MediaPreviewPageState> emit) {
    emit(state.copyWith(isPlayingVideoMode: true));
  }

  void _onChangedContentEvent(ChangedContentEvent event, Emitter<MediaPreviewPageState> emit) {
    emit(state.copyWith(
      mediaFileIndex: event.newIndex,
      isPlayingVideoMode: false,
    ));
  }

  void _onChangedOrientationEvent(
      ChangedOrientationEvent event, Emitter<MediaPreviewPageState> emit) {
    emit(state.copyWith(isLandscapeOrientation: event.isLandscapeOrientation));
  }

  void _onUpdateUiEvent(UpdateUiEvent event, Emitter emit) {
    emit(state.copyWith());
  }

  Future<void> _onInitialEvent(InitialEvent event, Emitter emit) async {
    for (MediaFileModel mediaFile in mediaFiles) {
      final file = File(mediaFile.stepFile!.path!);
      if (mediaFile.contentType == CameraContentType.photo) {
        final listBytes = await file.readAsBytes();
        final decodedMediaFile = await decodeImageFromList(listBytes);
        contentOrientationsIsPortraitList.add(decodedMediaFile.height > decodedMediaFile.width);
      } else {
        final videoController = VideoPlayerController.file(file);
        await videoController.initialize();
        contentOrientationsIsPortraitList
            .add(videoController.value.size.height > videoController.value.size.width);
        await videoController.dispose();
      }
    }
    emit(state.copyWith(
      contentOrientationsIsPortraitList: contentOrientationsIsPortraitList,
      isPageLoading: false,
    ));
  }
}
