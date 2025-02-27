import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/camera_mode.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/video_recording_info.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_multimedia_model.dart';
import 'package:meta/meta.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'camera_event.dart';

part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final ReviewTemplateStepModel step;
  final CameraMode cameraMode;
  ReviewTemplateStepMultimediaModel multimediaModel;

  CameraBloc(this.step, this.cameraMode, this.multimediaModel)
      : super(CameraState(
          cameraMode: cameraMode,
          videoRecordingInfo: VideoRecordingInfo(),
        )) {
    on<ChangeFlashModeEvent>(_onChangeFlashModeEvent);
    on<ChangeCameraEvent>(_onChangeCameraEvent);
    on<ChangeOrientationEvent>(_onChangeOrientation);
    on<InitializedCameraEvent>(_onInitializedCameraEvent);
    on<UpdateVideoRecordingTimeEvent>(_onUpdateVideoRecordingTimeEvent);
    on<StartVideoEvent>(_onStartVideoEvent);
    on<FinishVideoEvent>(_onFinishVideoEvent);
    on<CreatedPhotoEvent>(_onCreatedPhotoEvent);
    on<DeactivateCameraEvent>(_onDeactivateCameraEvent);
    on<InitCameraEvent>(_onUpdatePageEvent);
    on<EnableCameraEvent>(_onEnableCameraEvent);
    on<ChangedCameraModeEvent>(_onChangedCameraModeEvent);
  }

  _onChangeOrientation(
      ChangeOrientationEvent event, Emitter<CameraState> emit) {
    emit(state.copyWith(orientationAngle: event.newOrientation.angle()));
  }

  Future<void> _onChangeCameraEvent(_, Emitter<CameraState> emit) async {
    final cameraIndex = state.cameraIndex == 0 ? 1 : 0;
    emit(state.copyWith(
      isCameraReady: false,
      isNeedInitializeCamera: true,
      cameraIndex: cameraIndex,
    ));
  }

  Future<void> _onChangeFlashModeEvent(_, Emitter<CameraState> emit) async {
    final flashModes = state.cameraMode.getListFlashModes();
    final flashModeIndex = state.flashModeIndex == flashModes.length - 1
        ? 0
        : state.flashModeIndex + 1;
    emit(state.copyWith(flashModeIndex: flashModeIndex));
  }

  Future<void> _onInitializedCameraEvent(_, Emitter<CameraState> emit) async {
    emit(state.copyWith(
      isCameraReady: true,
      isNeedInitializeCamera: false,
      videoRecordingInfo: _parseVideoInfo(),
      isCameraEnable: true,
    ));
  }

  Future<void> _onUpdateVideoRecordingTimeEvent(
      _, Emitter<CameraState> emit) async {
    final actualRecordingDuration =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).round() -
            state.videoRecordingInfo!.startedRecordingAt!;
    if (actualRecordingDuration == state.videoRecordingInfo?.durationMax) {
      add(FinishVideoEvent());
      return;
    }
    emit(state.copyWith(
      videoRecordingInfo: state.videoRecordingInfo?.copyWith(
        actualRecordingDuration: actualRecordingDuration,
      ),
    ));
  }

  FutureOr<void> _onStartVideoEvent(_, Emitter<CameraState> emit) {
    emit(state.copyWith(
      startedOrientationAngle: state.orientationAngle,
      videoRecordingInfo: state.videoRecordingInfo?.copyWith(
        startedRecordingAt:
            (DateTime.now().millisecondsSinceEpoch ~/ 1000).round(),
        isRecording: true,
      ),
    ));
  }

  Future<void> _onFinishVideoEvent(_, Emitter<CameraState> emit) async {
    emit(state.copyWith(
      isCameraEnable: false,
      videoRecordingInfo: state.videoRecordingInfo!.copyWith(
        isRecording: false,
        actualRecordingDuration: 0,
      ),
    ));
  }

  Future<void> _onCreatedPhotoEvent(_, Emitter<CameraState> emit) async {
    emit(state.copyWith(
      isCameraEnable: false,
      startedOrientationAngle: state.orientationAngle,
    ));
  }

  Future<void> _onDeactivateCameraEvent(_, Emitter<CameraState> emit) async {
    emit(state.copyWith(isCameraReady: false));
  }

  Future<void> _onUpdatePageEvent(_, Emitter<CameraState> emit) async {
    emit(state.copyWith(isCameraEnable: false, isNeedInitializeCamera: true));
  }

  VideoRecordingInfo? _parseVideoInfo() {
    try {
      if (multimediaModel.maxDuration == 0 ||
          multimediaModel.maxDuration! <= multimediaModel.minDuration!) {
        throw new Exception('Invalid limitVideoDuration');
      }
      return state.cameraMode == CameraMode.photo
          ? null
          : VideoRecordingInfo(
              durationMax: multimediaModel.maxDuration!,
              durationMin: multimediaModel.minDuration!,
            );
    } catch (exception, stackTrace) {
      Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return VideoRecordingInfo();
    }
  }

  void _onEnableCameraEvent(_, Emitter<CameraState> emit) {
    emit(state.copyWith(isCameraEnable: true));
  }

  void _onChangedCameraModeEvent(
      ChangedCameraModeEvent event, Emitter<CameraState> emit) {
    emit(state.copyWith(
      cameraMode: state.cameraMode == CameraMode.photo
          ? CameraMode.video
          : CameraMode.photo,
    ));

    this.multimediaModel = event.multimediaModel;
    emit(state.copyWith(
      flashModeIndex: 0,
      videoRecordingInfo: _parseVideoInfo(),
    ));
  }
}
