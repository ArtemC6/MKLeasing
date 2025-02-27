import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/bloc/camera_bloc.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/managers/camera_file_manager.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/camera_mode.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_hash_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

const smallPreviewSizeCoefficient = 4.5;

class SmallPreviewWidget extends StatefulWidget {
  final MediaFileModel initialMediaFile;
  final Function(MediaFileModel) onFileSaved;
  final Function() onTap;
  final ReviewTemplateStepModel step;
  final Function(MediaFileModel) onDelete;
  final CameraState cameraState;
  final CameraFileManager fileManager;

  SmallPreviewWidget(
    this.initialMediaFile, {
    Key? key,
    required this.onFileSaved,
    required this.step,
    required this.onDelete,
    required this.cameraState,
    required this.fileManager,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmallPreviewWidgetState();
}

class _SmallPreviewWidgetState extends State<SmallPreviewWidget> {
  final CameraFileManager fileManager = getIt();
  late MediaFileModel mediaFile;
  double? widgetSize;

  @override
  void initState() {
    super.initState();
    mediaFile = widget.initialMediaFile;
    if (mediaFile.stepFile == null) {
      _saveMediaFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    widgetSize ??=
        MediaQuery.of(context).size.width / smallPreviewSizeCoefficient;
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Container(
          constraints: BoxConstraints(
            maxHeight: widgetSize!,
            maxWidth: widgetSize!,
          ),
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.up,
            onDismissed: (_) {
              widget.onDelete(mediaFile);
            },
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.red.withOpacity(0.4),
                    Colors.red,
                  ],
                ),
              ),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: widgetSize! / 2.7,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                if (mediaFile.stepFile != null) {
                  widget.onTap();
                }
              },
              child: Stack(
                children: [
                  Container(
                    width: widgetSize!,
                    height: widgetSize!,
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 3,
                          spreadRadius: 1.0,
                          offset: Offset(0, 1.5),
                        ),
                      ],
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Color(0xFFD3D3D3),
                        width: 1,
                      ),
                    ),
                    child: widget.initialMediaFile.contentType ==
                                CameraContentType.photo ||
                            mediaFile.isSaved
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(11.0),
                            child: Image.file(
                              File(
                                mediaFile.isSaved
                                    ? mediaFile.stepFile!.compressedPath!
                                    : mediaFile.file!.path,
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : SizedBox(),
                  ),
                  if (!mediaFile.isSaved)
                    Center(
                      child: SizedBox(
                        width: widgetSize! / 3,
                        height: widgetSize! / 3,
                        child: CircularProgressIndicator(
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  if (mediaFile.isSaved)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 13),
                        child: SizedBox(
                            width: widgetSize! / 4.5,
                            height: widgetSize! / 4.5,
                            child: SvgPicture.asset(
                              'assets/icons/edit.svg',
                              color: Colors.white,
                            )),
                      ),
                    ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => widget.onDelete(mediaFile),
                      child: Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              spreadRadius: 0.7,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.clear,
                          size: 16,
                          color: Color(0xFFC07777),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.initialMediaFile.contentType ==
                            CameraContentType.video &&
                        mediaFile.stepFile != null,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: widgetSize! / 2.3,
                        color: Color(0xFFABABAB),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _saveMediaFile() async {
    final Map<String, String> fileInfo;
    if (widget.initialMediaFile.contentType == CameraContentType.photo) {
      fileInfo = await fileManager.savePhoto(mediaFile.file!);
    } else {
      fileInfo = await fileManager.saveVideo(
        widget.initialMediaFile.file!,
        widget.cameraState.videoRecordingInfo!.startedRecordingAt!,
      );
      final previewImage = await VideoThumbnail.thumbnailData(
        video: fileInfo['path']!,
        imageFormat: ImageFormat.JPEG,
        quality: 70,
      );
      await File(fileInfo['compressedPath']!).writeAsBytes(previewImage!);
    }
    DateTime onDeviceCreatedAt = DateTime.now();
    final stepFile = ReviewStepFileDTO(
      stepId: widget.step.localId,
      type: widget.initialMediaFile.contentType.name,
      path: fileInfo['path']!,
      compressedPath: fileInfo['compressedPath'],
      hash: await getIt<FileHashService>().md5Hash(fileInfo['path']!),
      onDeviceCreatedAt: onDeviceCreatedAt,
      createdAt: onDeviceCreatedAt.toUtc(),
    );
    mediaFile = mediaFile.copyWith(stepFile: stepFile, isSaved: true);
    widget.onFileSaved(mediaFile);
    if (mounted) {
      setState(() {});
    }
  }
}
