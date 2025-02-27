part of 'camera_bloc.dart';

@immutable
abstract class CameraEvent {}

class InitCameraEvent extends CameraEvent {}

class InitializedCameraEvent extends CameraEvent {}

class EnableCameraEvent extends CameraEvent {}

class DeactivateCameraEvent extends CameraEvent {}

class ChangeFlashModeEvent extends CameraEvent {}

class ChangeCameraEvent extends CameraEvent {}

class UpdateVideoRecordingTimeEvent extends CameraEvent {}

class StartVideoEvent extends CameraEvent {}

class FinishVideoEvent extends CameraEvent {}

class CreatedPhotoEvent extends CameraEvent {}

class ChangedCameraModeEvent extends CameraEvent {
  final ReviewTemplateStepMultimediaModel multimediaModel;

  ChangedCameraModeEvent(this.multimediaModel);
}

class ChangeOrientationEvent extends CameraEvent {
  final NativeDeviceOrientation newOrientation;

  ChangeOrientationEvent({required this.newOrientation});
}
