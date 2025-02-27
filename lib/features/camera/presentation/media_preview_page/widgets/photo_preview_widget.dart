import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';

class PhotoPreviewWidget extends StatelessWidget {
  final MediaFileModel mediaFile;
  final bool photoOrientationIsPortrait;

  const PhotoPreviewWidget({
    Key? key,
    required this.mediaFile,
    required this.photoOrientationIsPortrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: mediaFile.isSaved
          ? ExtendedImage.file(
              File(mediaFile.stepFile!.path!),
              mode: ExtendedImageMode.gesture,
              fit: photoOrientationIsPortrait ? BoxFit.fitHeight : null,
              initGestureConfigHandler: (state) {
                return GestureConfig(
                  minScale: 1.0,
                  maxScale: 3.0,
                  inPageView: true,
                );
              },
            )
          : Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
