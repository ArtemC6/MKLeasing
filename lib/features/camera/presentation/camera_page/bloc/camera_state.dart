part of 'camera_bloc.dart';

class CameraState {
  final bool isCameraReady;
  final bool isCameraEnable;
  final bool isNeedInitializeCamera;
  final int cameraIndex;
  final CameraMode cameraMode;
  final double orientationAngle;
  final int flashModeIndex;
  final double startedOrientationAngle;
  final VideoRecordingInfo? videoRecordingInfo;

  CameraState({
    this.isCameraReady = false,
    this.cameraIndex = 0,
    required this.cameraMode,
    this.orientationAngle = 0,
    this.flashModeIndex = 0,
    this.isCameraEnable = true,
    this.videoRecordingInfo,
    this.isNeedInitializeCamera = true,
    this.startedOrientationAngle = 0,
  });

  CameraState copyWith({
    int? cameraIndex,
    CameraMode? cameraMode,
    double? orientationAngle,
    int? flashModeIndex,
    bool? isCameraReady,
    VideoRecordingInfo? videoRecordingInfo,
    bool? isCameraEnable,
    bool? isNeedInitializeCamera,
    double? startedOrientationAngle,
  }) {
    return CameraState(
      cameraIndex: cameraIndex ?? this.cameraIndex,
      cameraMode: cameraMode ?? this.cameraMode,
      orientationAngle: orientationAngle ?? this.orientationAngle,
      flashModeIndex: flashModeIndex ?? this.flashModeIndex,
      isCameraReady: isCameraReady ?? this.isCameraReady,
      videoRecordingInfo: videoRecordingInfo ?? this.videoRecordingInfo,
      isCameraEnable: isCameraEnable ?? this.isCameraEnable,
      isNeedInitializeCamera:
          isNeedInitializeCamera ?? this.isNeedInitializeCamera,
      startedOrientationAngle:
          startedOrientationAngle ?? this.startedOrientationAngle,
    );
  }
}
