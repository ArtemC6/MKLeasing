// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget showing a live camera preview.
class CustomCameraPreview extends StatelessWidget {
  /// Creates a preview widget for the given camera controller.
  const CustomCameraPreview(this.controller, {required this.child, this.maskPath});

  /// The controller for the camera that the preview is shown for.
  final CameraController controller;

  /// A widget to overlay on top of the camera preview
  final Widget child;

  final String? maskPath;

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              var deviceOrientation = _getApplicableOrientation();

              Size mediaScreen = MediaQuery.of(context).size;

              var systemPaddingHeight = MediaQuery.of(context).padding.top +
                  MediaQuery.of(context).padding.bottom;

              late double maxHeight;
              late double maxWidth;
              late double aspectRatio;

              if (Platform.isIOS) {
                maxHeight = [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ].contains(deviceOrientation)
                    ? mediaScreen.height
                    : mediaScreen.width + systemPaddingHeight;

                maxWidth = [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ].contains(deviceOrientation)
                    ? mediaScreen.width + systemPaddingHeight
                    : mediaScreen.height;

                aspectRatio = [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ].contains(deviceOrientation)
                    ? 1 / controller.value.aspectRatio
                    : controller.value.aspectRatio;
              } else {
                maxHeight = mediaScreen.height;
                maxWidth = mediaScreen.width + systemPaddingHeight;
                aspectRatio = 1 / controller.value.aspectRatio;
              }

              return Stack(
                fit: StackFit.passthrough,
                children: [
                  _wrapInRotatedBox(
                    child: OverflowBox(
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                        child: AspectRatio(
                          aspectRatio: aspectRatio,
                          child: controller.buildPreview(),
                        )),
                  ),
                  if (this.maskPath != null)
                    RotatedBox(
                        quarterTurns: _getMaskQuarterTurns(),
                        child: OverflowBox(
                            maxHeight: mediaScreen.height,
                            // выглядит как баг, но почему-то работает корректно на обоих платформах
                            maxWidth: mediaScreen.height,
                            child: Center(
                              child: Image.file(
                                File(maskPath!),
                                alignment: Alignment.centerLeft,
                              ),
                            ))),
                  child ?? Container(),
                ],
              );
            },
            child: child,
          )
        : Container();
  }

  Widget _wrapInRotatedBox({required Widget child}) {

    return RotatedBox(
      quarterTurns: _getQuarterTurns(),
      child: child,
    );
  }

  int _getQuarterTurns() {
    if (Platform.isIOS) return 0;
    Map<DeviceOrientation, int> turns = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeRight: 1,
      DeviceOrientation.portraitDown: 2,
      DeviceOrientation.landscapeLeft: 3,
    };
    return turns[_getApplicableOrientation()]!;
  }

  int _getMaskQuarterTurns() {
    Map<DeviceOrientation, int> turns = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeRight: 3,
      DeviceOrientation.portraitDown: 2,
      DeviceOrientation.landscapeLeft: 3,
    };
    return turns[_getApplicableOrientation()]!;
  }

  DeviceOrientation _getApplicableOrientation() {
    return controller.value.isRecordingVideo
        ? controller.value.recordingOrientation!
        : (controller.value.previewPauseOrientation ??
            controller.value.lockedCaptureOrientation ??
            controller.value.deviceOrientation);
  }
}
