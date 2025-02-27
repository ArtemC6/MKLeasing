import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

enum CameraMode {
  photo,
  video,
}

enum CameraContentType {
  photo,
  video,
}

extension CameraModeExtension on CameraMode {
  static CameraMode parse({required String contentType}) {
    return contentType == StepContentType.photo.name
        ? CameraMode.photo
        : CameraMode.video;
  }

  IconData getButtonIcon() {
    return this == CameraMode.photo
        ? Icons.photo_camera_rounded
        : Icons.videocam;
  }

  String getLocalizedModeName(BuildContext context) {
    return this == CameraMode.photo
        ? S.of(context).reviewStepsCreateScreenPhoto
        : S.of(context).reviewStepsCreateScreenVideo;
  }

  FlashMode getFlashModeByIndex(int flashModeIndex) {
    return getListFlashModes()[flashModeIndex];
  }

  List<FlashMode> getListFlashModes() {
    return this == CameraMode.photo
        ? List.of([
            FlashMode.auto,
            FlashMode.off,
            FlashMode.always,
            FlashMode.torch,
          ])
        : List.of([FlashMode.off, FlashMode.torch]);
  }
}

extension IconFlashMode on FlashMode {
  IconData icon() {
    switch (this) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.torch:
        return Icons.highlight;
    }
  }
}

extension AddAngletoDeviceOrientation on NativeDeviceOrientation {
  double angle() {
    switch (this) {
      case NativeDeviceOrientation.portraitUp:
        return 0;
      case NativeDeviceOrientation.landscapeRight:
        return -1 / 4;
      case NativeDeviceOrientation.portraitDown:
        return 1 / 2;
      case NativeDeviceOrientation.landscapeLeft:
        return 1 / 4;
      case NativeDeviceOrientation.unknown:
        return 0;
    }
  }

  DeviceOrientation toDeviceOrientation() =>
      switch (this) {
        NativeDeviceOrientation.portraitUp => DeviceOrientation.portraitUp,
        NativeDeviceOrientation.portraitDown => DeviceOrientation.portraitDown,
        NativeDeviceOrientation.landscapeLeft => DeviceOrientation.landscapeLeft,
        NativeDeviceOrientation.landscapeRight => DeviceOrientation.landscapeRight,
        NativeDeviceOrientation.unknown => DeviceOrientation.portraitUp
      };
}

extension DeviceOrientationExtension on DeviceOrientation {
  static DeviceOrientation parse(double value) {
    if (value == 0) {
      return DeviceOrientation.portraitUp;
    } else if (value == 1 / 4) {
      return DeviceOrientation.landscapeLeft;
    } else if (value == -1 / 4) {
      return DeviceOrientation.landscapeRight;
    } else {
      return DeviceOrientation.portraitDown;
    }
  }
}

extension RotationAngle on double {
  double toPi() {
    if (this == 1 / 4)
      return pi / 2;
    else if (this == 1 / 2)
      return pi;
    else if (this == -1 / 4)
      return -pi / 2;
    else
      return 0;
  }
}

extension CameraContentTypeExt on CameraContentType {
  static CameraContentType parseFromSting(String type) {
    if (type == StepContentType.photo.name ||
        type == StepContentType.document.name ||
        type == StepContentType.picture.name) {
      return CameraContentType.photo;
    } else if (type == StepContentType.video.name) {
      return CameraContentType.video;
    }
    return CameraContentType.photo;
  }
}
