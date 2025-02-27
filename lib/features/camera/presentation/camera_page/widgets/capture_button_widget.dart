import 'package:flutter/material.dart';
import 'package:leasing_company/core/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/camera_mode.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/video_recording_info.dart';

class CaptureButtonWidget extends StatelessWidget {
  final CameraMode cameraMode;
  final VideoRecordingInfo? videoRecordingInfo;
  final double orientationAngle;
  final Function() onPressed;
  final bool isButtonEnable;

  CaptureButtonWidget({
    Key? key,
    required this.cameraMode,
    required this.videoRecordingInfo,
    required this.orientationAngle,
    required this.onPressed,
    required this.isButtonEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cameraMode == CameraMode.video && videoRecordingInfo!.isRecording
        ? CustomCircularProgressIndicator(
            max: videoRecordingInfo!.durationMax,
            min: videoRecordingInfo!.durationMin,
            current: videoRecordingInfo!.actualRecordingDuration,
            child: button(),
          )
        : Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: isButtonEnable ? Colors.white : Colors.grey,
                  width: 2.5),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(3),
            child: button(),
          );
  }

  Color buttonCaptureColor() {
    if (cameraMode == CameraMode.photo) {
      return Colors.white;
    }
    if (cameraMode == CameraMode.video) {
      if (videoRecordingInfo!.isRecording) {
        return Color(0xfffd3b33);
      } else {
        return Color(0xfffd3b33);
      }
    }
    return Colors.yellowAccent;
  }

  Widget button() {
    return FloatingActionButton(
      heroTag: "capture",
      onPressed: isButtonEnable ? onPressed : null,
      child: AnimatedRotation(
        turns: orientationAngle,
        duration: Duration(milliseconds: 400),
        child: cameraMode == CameraMode.video && videoRecordingInfo!.isRecording
            ? Text((videoRecordingInfo!.durationMax -
                    videoRecordingInfo!.actualRecordingDuration)
                .toString())
            : null,
      ),
      backgroundColor: buttonCaptureColor(),
    );
  }
}
