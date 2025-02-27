import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/core/managers/permission_manager.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/bloc/camera_bloc.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/managers/camera_file_manager.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/camera_mode.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/widgets/capture_button_widget.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/widgets/custom_camera_preview.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/widgets/small_preview_widget.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/widgets/zoom_widget.dart';
import 'package:leasing_company/features/camera/presentation/compressing_page/page/compressing_video_page.dart';
import 'package:leasing_company/features/camera/presentation/media_preview_page/page/media_preview_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_multimedia_model.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:logging/logging.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

const double _initialMaxZoomLevel = 5;

class CameraPage extends StatefulWidget {
  final ReviewTemplateStepModel step;
  final List<ReviewStepFile> files;
  final Function(ReviewStepFile) onDeleteStepFile;
  final List<ReviewTemplateStepMultimediaModel> multimediaTypes;
  final CameraMode initialCameraMode;

  CameraPage({
    Key? key,
    required this.step,
    required this.files,
    required this.onDeleteStepFile,
    required this.multimediaTypes,
    required this.initialCameraMode,
  });

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  final ToastService toastService = getIt();
  final CameraFileManager fileManager = getIt();
  late final CameraBloc bloc;
  StreamSubscription<NativeDeviceOrientation>? deviceOrientationSubscription;
  Timer? timer;
  CameraController? _controller;
  double maxZoomLevel = _initialMaxZoomLevel;
  List<MediaFileModel> mediaFiles = [];
  late CameraMode currentCameraMode = widget.initialCameraMode;
  late ReviewTemplateStepMultimediaModel currentMultimediaType;
  late final countMediaFiles = ValueNotifier(widget.files.where((element) => element.type == currentCameraMode.name).length);
  bool isHavePermissions = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setAsset('assets/sounds/photo_sound.mp3');
    widget.files.reversed.toList().forEach((element) {
      mediaFiles.add(
        MediaFileModel(
          contentType: element.type == StepContentType.photo.name ? CameraContentType.photo : CameraContentType.video,
          file: null,
          stepFile: ReviewStepFileDTO.fromReviewStepFile(element),
          isSaved: true,
        ),
      );
    });
    _checkPermissions();
    currentMultimediaType = widget.multimediaTypes.where((element) => element.stepContentType.name == currentCameraMode.name).first;
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _checkPermissions() async {
    isHavePermissions = await getIt<PermissionManager>().checkPermissions(
      context,
      permissions: currentCameraMode == CameraMode.photo ? [Permission.camera] : [Permission.camera, Permission.microphone],
    );
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ));
    deviceOrientationSubscription?.cancel();
    _controller?.dispose();
    timer?.cancel();
    _controller = null;
    deviceOrientationSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
      ));
    });
    return BlocProvider<CameraBloc>(
      create: (_) {
        bloc = CameraBloc(
          widget.step,
          currentCameraMode,
          currentMultimediaType,
        );
        return bloc;
      },
      child: WillPopScope(
        onWillPop: () async {
          await _onClose(context, false);
          return false;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              centerTitle: true,
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Material(
                        textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        color: Color(0xFF21A63E).withOpacity(0.8),
                        child: InkWell(
                          highlightColor: Colors.white38,
                          splashColor: Colors.white54,
                          onTap: () {
                            _onClose(context, true);
                          },
                          child: Ink(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 12,
                              ),
                              child: Text(S.of(context).ok),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Stack(children: [
              BlocBuilder<CameraBloc, CameraState>(
                  buildWhen: (prev, current) =>
                      prev.isCameraReady != current.isCameraReady ||
                      prev.isNeedInitializeCamera != current.isNeedInitializeCamera ||
                      prev.orientationAngle != current.orientationAngle,
                  builder: (context, state) {
                    if (isHavePermissions && !state.isCameraReady && state.isNeedInitializeCamera) {
                      _initializeCamera(state.cameraIndex, state.cameraMode);
                    }
                    return state.isCameraReady
                        ? Align(
                            alignment: Alignment.center,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: state.orientationAngle == 0 ? MediaQuery.sizeOf(context).height : MediaQuery.sizeOf(context).width,
                                maxWidth: state.orientationAngle == 0 ? MediaQuery.sizeOf(context).width : MediaQuery.sizeOf(context).height,
                              ),
                              child: state.videoRecordingInfo?.isRecording == true
                                  ? cameraPreview()
                                  : Transform.rotate(
                                      angle: state.orientationAngle.toPi(),
                                      child: cameraPreview(),
                                    ),
                            ),
                          )
                        : Container(
                            color: Colors.black,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                  }),
              Stack(children: [
                BlocBuilder<CameraBloc, CameraState>(builder: (context, state) {
                  return ZoomWidget(
                    onChangeZoomLevel: (zoomLevel) {
                      _controller?.setZoomLevel(zoomLevel);
                    },
                    maxZoomLevel: maxZoomLevel,
                    cameraState: state,
                  );
                }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / smallPreviewSizeCoefficient * 2,
                      child: ValueListenableBuilder(
                          key: UniqueKey(),
                          valueListenable: countMediaFiles,
                          builder: (context, value, _) {
                            return ListView.builder(
                                itemCount: mediaFiles.length,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                scrollDirection: Axis.horizontal,
                                cacheExtent: MediaQuery.of(context).size.width * 6,
                                itemBuilder: (context, index) {
                                  return SmallPreviewWidget(
                                    mediaFiles[index],
                                    key: UniqueKey(),
                                    onFileSaved: (mediaFile) {
                                      mediaFiles[index] = mediaFile;
                                    },
                                    step: widget.step,
                                    onDelete: _onDeleteMediaFile,
                                    cameraState: context.read<CameraBloc>().state,
                                    fileManager: fileManager,
                                    onTap: () async {
                                      bloc.add(DeactivateCameraEvent());
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => MediaPreviewPage(
                                            mediaFiles: mediaFiles,
                                            initialIndex: index,
                                            onChangedComment: (int index, String comment) {
                                              mediaFiles[index] = mediaFiles[index].copyWith(
                                                    stepFile: mediaFiles[index].stepFile?.copyWith(comment: comment),
                                                  );
                                            },
                                            onDelete: _onDeleteMediaFile,
                                            isOpenedFromCamera: true,
                                          ),
                                        ),
                                      );
                                      bloc.add(InitCameraEvent());
                                    },
                                  );
                                });
                          }),
                    ),
                    SizedBox(height: 10.0),
                    _fileLimitsInfoWidget(),
                    BlocConsumer<CameraBloc, CameraState>(listenWhen: (prev, current) {
                      currentCameraMode = current.cameraMode;
                      if (prev.cameraMode != current.cameraMode) _checkPermissions();
                      currentMultimediaType = widget.multimediaTypes.where((element) => element.stepContentType.name == currentCameraMode.name).first;
                      countMediaFiles.value = mediaFiles.where((element) => element.contentType.name == currentMultimediaType.stepContentType.name).length;
                      return true;
                    }, listener: (context, state) async {
                      if (state.cameraMode == CameraMode.video && state.videoRecordingInfo!.durationMax <= state.videoRecordingInfo!.actualRecordingDuration) {
                        _finishVideo(state);
                      }
                    }, builder: (context, state) {
                      if (_controller != null && _controller!.value.isInitialized) {
                        _controller!.setFlashMode(state.cameraMode.getFlashModeByIndex(state.flashModeIndex));
                      }
                      return Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 16.0, top: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FloatingActionButton(
                                    heroTag: "switch-flash",
                                    child: AnimatedRotation(
                                      turns: state.orientationAngle,
                                      duration: Duration(milliseconds: 400),
                                      child: Icon(state.cameraMode.getFlashModeByIndex(state.flashModeIndex).icon(), color: Colors.white),
                                    ),
                                    onPressed: () {
                                      context.read<CameraBloc>().add(ChangeFlashModeEvent());
                                    },
                                    backgroundColor: Colors.black.withOpacity(0.75),
                                  ),
                                  CaptureButtonWidget(
                                    cameraMode: state.cameraMode,
                                    videoRecordingInfo: state.videoRecordingInfo,
                                    orientationAngle: state.orientationAngle,
                                    isButtonEnable: state.isCameraEnable,
                                    onPressed: () {
                                      _onPressedCaptureButton(state);
                                    },
                                  ),
                                  Visibility(
                                    visible: !(state.videoRecordingInfo != null && state.videoRecordingInfo!.isRecording),
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    child: FloatingActionButton(
                                      heroTag: "switch-camera",
                                      onPressed: () {
                                        context.read<CameraBloc>().add(ChangeCameraEvent());
                                      },
                                      child: AnimatedRotation(
                                          turns: state.orientationAngle, duration: Duration(milliseconds: 400), child: Icon(Icons.loop_outlined)),
                                      backgroundColor: Colors.black.withOpacity(0.75),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (widget.multimediaTypes.length > 1) _buildToggleCameraModeButtons(),
                            if (widget.multimediaTypes.length > 1) SizedBox(height: 10),
                            SizedBox(height: 12),
                          ],
                        ),
                      );
                    }),
                  ]),
                ),
              ]),
            ])),
      ),
    );
  }

  Widget _buildToggleCameraModeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: CameraMode.values
          .map((e) => InkWell(
                onTap: () {
                  if (e != currentCameraMode && !(currentCameraMode == CameraMode.video && bloc.state.videoRecordingInfo?.isRecording == true)) {
                    currentMultimediaType = widget.multimediaTypes.where((element) => element.stepContentType.name != currentCameraMode.name).first;

                    bloc.add(ChangedCameraModeEvent(currentMultimediaType));
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: AnimatedContainer(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: currentCameraMode == e ? Colors.black : Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 6,
                  ),
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    e.getLocalizedModeName(context),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  void _initializeCamera(int cameraIndex, CameraMode cameraMode) async {
    try {
      if (!mounted) return;
      ResolutionPreset resolution = cameraMode == CameraMode.photo ? ResolutionPreset.veryHigh : ResolutionPreset.high;
      final _cameras = await availableCameras();
      _controller = null;
      _controller = CameraController(
        _cameras[cameraIndex],
        resolution,
        enableAudio: cameraMode == CameraMode.video,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await _controller!.initialize();
      maxZoomLevel = _controller!.value.isInitialized ? await _controller!.getMaxZoomLevel() : 5.0;
      final orientation = DeviceOrientationExtension.parse(bloc.state.orientationAngle);
      await _controller!.lockCaptureOrientation(orientation);
      deviceOrientationSubscription ??= NativeDeviceOrientationCommunicator().onOrientationChanged(useSensor: true).listen((newOrientation) async {
        if (mounted && bloc.state.videoRecordingInfo?.isRecording != true) {
          await Future.delayed(Duration(milliseconds: 300));
          if (_controller != null) {
            await _controller!.lockCaptureOrientation(newOrientation.toDeviceOrientation());
          }
          bloc.add(ChangeOrientationEvent(newOrientation: newOrientation));
        }
      });
      await fileManager.initialize();
      bloc.add(InitializedCameraEvent());
    } on CameraException catch (exception) {
      if (mounted) {
        toastService.showFailureToast(
          this.context,
          '${S.of(context).error}: ${exception.description}',
        );
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  void _takePhoto(CameraState cameraState) async {
    bloc.add(CreatedPhotoEvent());

    await _controller!.setFocusMode(FocusMode.locked);
    await _controller!.setExposureMode(ExposureMode.locked);
    final picture = await _controller!.takePicture();
    await player.seek(Duration.zero);
    await player.play();
    await _controller!.setFocusMode(FocusMode.auto);
    await _controller!.setExposureMode(ExposureMode.auto);
    mediaFiles.insert(
        0,
        MediaFileModel(
          contentType: CameraContentType.photo,
          file: picture,
          isSaved: false,
        ));
    countMediaFiles.value = mediaFiles.where((element) => element.contentType.name == currentMultimediaType.stepContentType.name).length;
    await Future.delayed(Duration(seconds: 1));
    bloc.add(EnableCameraEvent());
  }

  void _startVideo() {
    bloc.add(StartVideoEvent());
    _controller!.startVideoRecording();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      bloc.add(UpdateVideoRecordingTimeEvent());
    });
  }

  Future<void> _finishVideo(CameraState cameraState) async {
    final log = Logger('FinishVideoLogger');
    try {
      timer?.cancel();
      bloc.add(FinishVideoEvent());

      XFile file = await _controller!.stopVideoRecording();
      log.info('file path = ${file.path}');

      mediaFiles.insert(
          0,
          MediaFileModel(
            contentType: CameraContentType.video,
            file: file,
            isSaved: false,
          ));
      countMediaFiles.value = mediaFiles.where((element) => element.contentType.name == currentMultimediaType.stepContentType.name).length;
      await Future.delayed(Duration(seconds: 1));
      bloc.add(EnableCameraEvent());
    } catch (error, stackTrace) {
      log.info('CameraPage: _CameraPageState.finishVideo');
      log.severe('finishVideo Exception', error, stackTrace);
    }
  }

  void _onPressedCaptureButton(CameraState cameraState) {
    if (_controller == null) return;
    if ((!currentMultimediaType.multiple && countMediaFiles.value == 1) ||
        (currentMultimediaType.maxCount != 0 &&
            countMediaFiles.value ==
                (currentMultimediaType.minCount > currentMultimediaType.maxCount ? currentMultimediaType.minCount : currentMultimediaType.maxCount))) {
      toastService.showFailureToast(
        context,
        S.of(context).maximumNumberFilesReached,
        toastGravity: ToastGravity.TOP,
        color: Colors.red.withOpacity(0.75),
      );
    } else if (cameraState.cameraMode == CameraMode.photo) {
      _takePhoto(cameraState);
    } else if (cameraState.videoRecordingInfo!.isRecording) {
      if (cameraState.videoRecordingInfo!.actualRecordingDuration >= cameraState.videoRecordingInfo!.durationMin) {
        _finishVideo.call(cameraState);
      } else {
        toastService.showFailureToast(
          context,
          S.of(context).minimumVideoLengthNotReached,
          toastGravity: ToastGravity.TOP,
          color: Colors.red.withOpacity(0.75),
        );
      }
    } else {
      _startVideo();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
          () {
        bloc.add(InitCameraEvent());
      }.call();
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
          () {
        _controller?.dispose();
        _controller = null;
        timer?.cancel();
        timer = null;
        deviceOrientationSubscription?.cancel();
        if (currentCameraMode == CameraMode.video && bloc.state.videoRecordingInfo!.isRecording) {
          bloc.add(FinishVideoEvent());
        }
        bloc.add(DeactivateCameraEvent());
      }.call();
    }

  }

  Future<void> _onClose(BuildContext context, bool isOkButtonPressed) async {
    bool isNeedToSaveFiles = isOkButtonPressed;
    final log = Logger('OnCloseLogger');
    if (mediaFiles.isNotEmpty && !mediaFiles.first.isSaved)
      return;
    else {
      try {
        throw Exception('!mediaFiles.isNotEmpty && mediaFiles.first.isSaved Exception');
      } catch (error, stackTrace) {
        log.info('CameraPage: _CameraPageState._onClose');
        log.severe('mediaFiles.isNotEmpty = ${mediaFiles.isNotEmpty}', error, stackTrace);
        if (mediaFiles.isNotEmpty) log.severe('!mediaFiles.first.isSaved = ${!mediaFiles.first.isSaved}');
      }
    }
    final newMediaFiles = mediaFiles.where((element) => widget.files.where((file) => file.path == element.stepFile!.path).isEmpty).toList();
    await _clearCache(newMediaFiles);
    if (newMediaFiles.isNotEmpty && !isOkButtonPressed) {
      isNeedToSaveFiles = await getIt<DialogManager>().showSaveMediaFilesDialog(context);
    }
    deviceOrientationSubscription?.cancel();

    final newVideoFiles = newMediaFiles.where((element) => element.contentType == CameraContentType.video).toList();

    if (newVideoFiles.isNotEmpty && isNeedToSaveFiles) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CompressingVideoPage(mediaFiles: newVideoFiles),
        ),
      );
    }
    Navigator.of(context).pop(
      isNeedToSaveFiles ? newMediaFiles.map((e) => e.stepFile!).toList().reversed.toList() : List<ReviewStepFileDTO>.from([]),
    );
  }

  Widget cameraPreview() {
    return Center(
        child: CustomCameraPreview(
      _controller!,
      maskPath: widget.step.contentMask != null ? path.join(fileManager.cacheStorageDir, path.basename(widget.step.contentMask!)) : null,
      child: SizedBox(),
    ));
  }

  _onDeleteMediaFile(MediaFileModel mediaFile) async {
    setState(() {
      if (mediaFile.isSaved) {
        mediaFiles.remove(mediaFile);
        if (widget.files.where((element) => element.path == mediaFile.stepFile!.path).isNotEmpty) {
          widget.onDeleteStepFile(widget.files.where((element) => element.path == mediaFile.stepFile!.path).first);
        } else {
          fileManager.deleteFile(
            filePath: mediaFile.stepFile!.path!,
            compressedPath: mediaFile.stepFile!.compressedPath,
            cacheFilePath: mediaFile.file?.path,
          );
        }
        countMediaFiles.value = mediaFiles.where((element) => element.contentType.name == currentMultimediaType.stepContentType.name).length;
      }
    });
  }

  Future<void> _clearCache(List<MediaFileModel> mediaFiles) async {
    for (final mediaFile in mediaFiles) {
      await fileManager.deleteFile(cacheFilePath: mediaFile.file?.path);
    }
  }

  Widget _fileLimitsInfoWidget() {
    int minFileLimit = 0;
    int maxFileLimit = 0;

    if (currentMultimediaType.multiple) {
      minFileLimit = currentMultimediaType.minCount == 0 && widget.step.required ? 1 : currentMultimediaType.minCount;
      maxFileLimit = currentMultimediaType.multiple
          ? currentMultimediaType.maxCount >= currentMultimediaType.minCount
              ? currentMultimediaType.maxCount
              : currentMultimediaType.minCount
          : 1;
    } else {
      minFileLimit = widget.step.required ? 1 : 0;
      maxFileLimit = 1;
    }

    return ValueListenableBuilder(
      valueListenable: countMediaFiles,
      builder: (context, int value, _) {
        final limitFilesString = maxFileLimit > 0 ? '"$value/$maxFileLimit: Min $minFileLimit / Max $maxFileLimit"' : '"$value: Min $minFileLimit"';
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: value < minFileLimit ? Color(0xFFF75555) : Color(0xFF21A63E),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: value < minFileLimit
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.5),
                        child: Text(
                          '!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.5),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
              ),
            ),
            SizedBox(width: 6),
            Text(
              limitFilesString,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
