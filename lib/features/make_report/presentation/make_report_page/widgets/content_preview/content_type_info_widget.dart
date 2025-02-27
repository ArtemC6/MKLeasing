import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/camera_mode.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/page/camera_page.dart';
import 'package:leasing_company/features/camera/presentation/media_preview_page/page/media_preview_page.dart';
import 'package:leasing_company/features/make_document/presentation/make_document/page/make_document_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/audio_player_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/audio_recorder.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/step_skipped_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_multimedia_model.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_hash_service.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class ContentTypeInfoWidget extends StatelessWidget {
  final List<ReviewTemplateStepMultimediaModel> multimedia;
  final ReviewTemplateStepModel step;
  final List<ReviewStepFile> files;

  ContentTypeInfoWidget({
    Key? key,
    required this.multimedia,
    required this.step,
    required this.files,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Color(0xFF89B5FC).withOpacity(0.1),
        border: Border.all(color: Color(0xFF2871E6).withOpacity(0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: StepContentType.values.map((type) {
          final multimediaFiles = multimedia.where(
            (e) => e.stepContentType == type,
          );
          return _buildTypeItem(
            type,
            multimedia.map((e) => e.stepContentType).contains(type),
            context,
            multimediaFiles.isNotEmpty ? multimediaFiles.first : null,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTypeItem(
    StepContentType type,
    bool isActive,
    BuildContext context,
    ReviewTemplateStepMultimediaModel? multimediaModel,
  ) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (isActive && multimediaModel != null) {
            if (![
              StepContentType.photo,
              StepContentType.video,
            ].contains(multimediaModel.stepContentType)) {
              final maxFilesCount = multimediaModel.multiple ? multimediaModel.maxCount : 1;
              final currentMultimediaTypeFilesLength = files.where((file) => file.type == type.name).length;
              if (maxFilesCount > 0 && currentMultimediaTypeFilesLength >= maxFilesCount) {
                getIt<ToastService>().showFailureToast(
                  context,
                  S.of(context).maximumNumberFilesReached + ' - $maxFilesCount',
                );
                return;
              }
            }
            type.onAddContentTap(context, files, step, multimediaModel, multimedia).call();
          }
        },
        child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 2),
          padding: type.getIconPadding(),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      offset: Offset(0, 1.0),
                      spreadRadius: 0.1,
                      blurRadius: 1.8,
                      color: Colors.black.withOpacity(0.14),
                    )
                  ]
                : null,
            border: Border.all(
              width: 1.5,
              color: isActive ? Color(0xFF246BFD).withOpacity(0.7) : Color(0xFFEEEEEE),
            ),
          ),
          child: SvgPicture.asset(
            type.getIconAsset(),
            color: isActive ? Colors.black : Colors.black26,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

enum StepContentType {
  photo,
  video,
  file,
  document,
  audio,
  picture,
}

extension StepContentTypeExt on StepContentType {
  static StepContentType parse(String contentType) {
    switch (contentType) {
      case 'photo':
        return StepContentType.photo;
      case 'video':
        return StepContentType.video;
      case 'file':
        return StepContentType.file;
      case 'document':
        return StepContentType.document;
      case 'audio':
        return StepContentType.audio;
      case 'picture':
        return StepContentType.picture;
      default:
        return StepContentType.photo;
    }
  }

  String getIconAsset() {
    switch (this) {
      case StepContentType.photo:
        return 'assets/icons/photo.svg';
      case StepContentType.video:
        return 'assets/icons/video.svg';
      case StepContentType.file:
        return 'assets/icons/file.svg';
      case StepContentType.document:
        return 'assets/icons/scan.svg';
      case StepContentType.audio:
        return 'assets/icons/audio.svg';
      case StepContentType.picture:
        return 'assets/icons/gallery.svg';
    }
  }

  EdgeInsets getIconPadding() {
    switch (this) {
      case StepContentType.photo:
        return EdgeInsets.symmetric(horizontal: 8, vertical: 7);
      case StepContentType.video:
        return EdgeInsets.symmetric(horizontal: 8, vertical: 7);
      case StepContentType.file:
        return EdgeInsets.symmetric(horizontal: 8, vertical: 8);
      case StepContentType.document:
        return EdgeInsets.symmetric(horizontal: 8, vertical: 8);
      case StepContentType.audio:
        return EdgeInsets.symmetric(horizontal: 8, vertical: 8);
      case StepContentType.picture:
        return EdgeInsets.symmetric(horizontal: 8, vertical: 8);
    }
  }

  Function() onAddContentTap(
    BuildContext context,
    List<ReviewStepFile> files,
    ReviewTemplateStepModel step,
    ReviewTemplateStepMultimediaModel? multimediaModel,
    List<ReviewTemplateStepMultimediaModel> multimedia,
  ) {
    final bloc = context.read<MakeReportBloc>();
    switch (this) {
      case StepContentType.photo:
      case StepContentType.video:
        return () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraPage(
                step: step,
                files: files
                    .where((element) =>
                        element.stepId == step.localId &&
                        element.deletedByUserAt == null &&
                        element.path != null &&
                        (element.type == StepContentType.photo.name || element.type == StepContentType.video.name))
                    .toList(),
                onDeleteStepFile: (ReviewStepFile file) {
                  bloc.add(MakeReportDeleteFileEvent(file));
                },
                multimediaTypes: multimedia
                    .where((element) => element.stepContentType == StepContentType.photo || element.stepContentType == StepContentType.video)
                    .toList(),
                initialCameraMode: CameraModeExtension.parse(contentType: this.name),
              ),
            ),
          ).then((value) {
            if (value != null) {
              bloc.add(MakeReportAddingMediaFileEvent(value));
            }
          });
        };
      case StepContentType.document:
        return () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MakeDocumentPage(makeReportBloc: bloc, step: step),
            ),
          ).then((value) {
            if (value != null) {
              bloc.add(MakeReportAddingMediaFileEvent([value]));
            }
          });
        };
      case StepContentType.file:
        return () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.any,
            allowMultiple: multimediaModel!.multiple,
          );

          if (result != null) {
            for (PlatformFile file in result.files) {
              // ограничение в 768мб
              int mbLimit = 768;
              int limitSize = 1024 * 1024 * mbLimit;
              if (file.size > limitSize) {
                getIt<ToastService>().showFailureToast(
                  context,
                  S.of(context).makeReportPageHugeFile(
                        file.path.toString(),
                        mbLimit.toString(),
                      ),
                );
                continue;
              }

              String filepath = join(await getStorageDir(), Uuid().v4() + file.extension!);

              final sourceFile = File(file.path!);
              await sourceFile.copy(filepath);

              final now = DateTime.now();
              final stepFile = ReviewStepFileDTO(
                stepId: step.localId!,
                type: StepContentType.file.name,
                path: filepath,
                onDeviceCreatedAt: now,
                createdAt: now.toUtc(),
              );
              bloc.add(MakeReportAddingMediaFileEvent([stepFile]));
            }
          }
        };
      case StepContentType.audio:
        return () async {
          final record = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Expanded(child: SizedBox()),
                      Material(
                        color: Colors.white,
                        child: AudioRecorderWidget(
                          stepId: step.localId,
                          multimediaModel: multimedia.firstWhere((element) => element.stepContentType == this),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                );
              });
          if (record != null) {
            context.read<MakeReportBloc>().add(
                  MakeReportAddingMediaFileEvent([record]),
                );
          }
        };
      case StepContentType.picture:
        return () async {
          ImagePicker().pickMultiImage().then((value) async {
            final List<ReviewStepFileDTO> stepFiles = [];
            if (value != null) {
              final List<XFile> imageFiles;
              final savedFiles = files
                  .where((element) => element.stepId == step.localId && element.deletedByUserAt == null && element.path != null && element.type == this.name);
              final multimediaModel = multimedia.firstWhere((element) => element.stepContentType == this);

              final maxCount = multimediaModel.multiple ? multimediaModel.maxCount : 1;

              if (maxCount > 0 && value.length > maxCount - savedFiles.length) {
                imageFiles = getIt<ToastService>().showFailureToast(
                  context,
                  S.of(context).numberOfImagesExceeded + maxCount.toString(),
                  toastLength: Toast.LENGTH_LONG,
                );
              } else {
                imageFiles = value;
              }
              await Future.wait(imageFiles.map((element) async {
                DateTime onDeviceCreatedAt = DateTime.now();
                String filepath = join(await getStorageDir(), Uuid().v4() + extension(element.path));

                final sourceFile = File(element.path);
                await sourceFile.copy(filepath);

                stepFiles.add(ReviewStepFileDTO(
                  stepId: step.localId,
                  type: this.name,
                  path: filepath,
                  compressedPath: filepath,
                  hash: await getIt<FileHashService>().md5Hash(element.path),
                  onDeviceCreatedAt: onDeviceCreatedAt,
                  createdAt: onDeviceCreatedAt.toUtc(),
                ));
              }));
            }
            bloc.add(MakeReportAddingMediaFileEvent(stepFiles));
          });
        };
    }
  }

  Function() onMediaPreviewTap(
    ReviewStepFile stepFile,
    List<ReviewStepFile> files,
    BuildContext context,
  ) {
    switch (this) {
      case StepContentType.photo:
        return _openMediaPreviewPage(
          stepFile,
          files,
          context,
        );
      case StepContentType.video:
        return _openMediaPreviewPage(
          stepFile,
          files,
          context,
        );
      case StepContentType.file:
        return () {};
      case StepContentType.document:
        return _openMediaPreviewPage(
          stepFile,
          files,
          context,
        );
      case StepContentType.audio:
        return _openAudioPreview(
          stepFile,
          files,
          context,
        );
      case StepContentType.picture:
        return _openMediaPreviewPage(
          stepFile,
          files,
          context,
        );
    }
  }

  _openAudioPreview(
    ReviewStepFile stepFile,
    List<ReviewStepFile> files,
    BuildContext context,
  ) {
    return () {
      final bloc = context.read<MakeReportBloc>();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AudioPlayerPage(
            stepFile: stepFile,
            onChangedComment: (uuid, comment) {
              bloc.add(MakeReportChangeMediaCommentEvent(
                fileUuid: uuid,
                comment: comment,
              ));
            },
            onDelete: (file) {
              bloc.add(MakeReportDeleteFileEvent(file));
            },
          ),
        ),
      );
    };
  }

  List<Widget> previewContent(ReviewStepFile stepFile) {
    switch (this) {
      case StepContentType.photo:
        return _photoPreviewContent(stepFile);
      case StepContentType.video:
        return _videoPreviewContent(stepFile);
      case StepContentType.file:
        return _filePreviewContent(stepFile);
      case StepContentType.document:
        return _photoPreviewContent(stepFile);
      case StepContentType.audio:
        return _audioPreviewContent(stepFile);
      case StepContentType.picture:
        return _photoPreviewContent(stepFile);
    }
  }

  List<Widget> _photoPreviewContent(ReviewStepFile stepFile) {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: AspectRatio(
          aspectRatio: 1,
          child: stepFile.path != null
              ? Container(
                  color: Colors.white,
                  child: Container(
                    color: Color(0xFF89B5FC).withOpacity(0.1),
                    child: Image(
                      image: FileImage(File(stepFile.compressedPath!)),
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, im) {
                        return im == null ? child : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                )
              : StepSkippedWidget(stepFile: stepFile),
        ),
      ),
      if (stepFile.path != null) _contentTypeMarker(),
    ];
  }

  List<Widget> _videoPreviewContent(ReviewStepFile stepFile) {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: AspectRatio(
          aspectRatio: 1,
          child: stepFile.path != null
              ? stepFile.compressedPath == null
                  ? Container(
                      color: Colors.black,
                    )
                  : Image.file(
                      File(stepFile.compressedPath!),
                      fit: BoxFit.cover,
                    )
              : StepSkippedWidget(stepFile: stepFile),
        ),
      ),
      if (stepFile.path != null) _contentTypeMarker(),
    ];
  }

  List<Widget> _filePreviewContent(ReviewStepFile stepFile) {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: AspectRatio(
          aspectRatio: 1,
          child: stepFile.path != null
              ? Container(
                  color: Colors.white,
                  child: Container(
                    color: Color(0xFF89B5FC).withOpacity(0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/file.svg',
                          color: Color(0xFF89B5FC),
                          fit: BoxFit.contain,
                          height: 55,
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              offset: Offset(0, -1),
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 5,
                            ),
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8,
                            ),
                            child: Text(
                              stepFile.path!.substring(stepFile.path!.lastIndexOf('/') + 1),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        //SizedBox(height: 6),
                      ],
                    ),
                  ),
                )
              : StepSkippedWidget(stepFile: stepFile),
        ),
      )
    ];
  }

  List<Widget> _audioPreviewContent(ReviewStepFile stepFile) {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: AspectRatio(
          aspectRatio: 1,
          child: stepFile.path != null
              ? Container(
                  color: Colors.white,
                  child: Container(
                    color: Color(0xFF89B5FC).withOpacity(0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(30, (index) => Random().nextInt(30) + 4)
                                .map((e) => Container(
                                      margin: EdgeInsets.symmetric(horizontal: 0.7),
                                      width: 2,
                                      height: e.toDouble(),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF89B5FC),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFD9D9D9),
                              width: 1.5,
                            ),
                          ),
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.play_arrow,
                            color: Color(0xFF4B4B4B),
                            size: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              offset: Offset(0, -1),
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 5,
                            ),
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 7,
                            ),
                            child: Text(
                              stepFile.path!.substring(stepFile.path!.lastIndexOf('/') + 1 + 14, stepFile.path!.lastIndexOf('.')),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : StepSkippedWidget(stepFile: stepFile),
        ),
      )
    ];
  }

  Function() _openMediaPreviewPage(
    ReviewStepFile stepFile,
    List<ReviewStepFile> files,
    BuildContext context,
  ) {
    final bloc = context.read<MakeReportBloc>();
    final cameraStepFiles = files.where((element) =>
        element.type == StepContentType.photo.name ||
        element.type == StepContentType.document.name ||
        element.type == StepContentType.picture.name ||
        element.type == StepContentType.video.name);
    return () {
      if (stepFile.path != null) {
        final rFiles = cameraStepFiles.where((e) => e.path != null).toList().reversed.toList();
        final rIndex = rFiles.indexOf(stepFile);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MediaPreviewPage(
              isOpenedFromCamera: false,
              mediaFiles: rFiles
                  .map((e) => MediaFileModel(
                        contentType: CameraContentTypeExt.parseFromSting(e.type),
                        stepFile: ReviewStepFileDTO.fromReviewStepFile(e),
                        file: null,
                        isSaved: true,
                      ))
                  .toList(),
              initialIndex: rIndex,
              onDelete: (mediaFile) {
                bloc.add(MakeReportDeleteFileEvent(
                  files.where((element) => element.path == mediaFile.stepFile!.path).first,
                ));
                files.removeWhere((element) => element.path == mediaFile.stepFile!.path);
              },
              onChangedComment: (index, comment) {
                bloc.add(
                  MakeReportChangeMediaCommentEvent(
                    fileUuid: files.reversed.toList()[index].uuid,
                    comment: comment,
                  ),
                );
              },
            ),
          ),
        );
      }
    };
  }

  Widget _contentTypeMarker() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          margin: EdgeInsets.only(bottom: 8, left: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.35),
          ),
          child: SvgPicture.asset(
            this.getIconAsset(),
            color: Colors.white,
            height: 20,
          ),
        ),
      ),
    );
  }
}
