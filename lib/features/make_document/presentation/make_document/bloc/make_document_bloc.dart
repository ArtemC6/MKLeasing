import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/services/file_hash_service.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'make_document_event.dart';
import 'make_document_state.dart';

class MakeDocumentBloc extends Bloc<MakeDocumentEvent, MakeDocumentState> {
  final ReviewTemplateStepModel step;
  final MakeReportBloc makeReportBloc;
  final S strings;
  final FileHashService fileHashService;
  
  MakeDocumentBloc(this.step, this.makeReportBloc, this.strings, this.fileHashService) : super(MakeDocumentInitial()) {
    on<InitializeEvent>(_initPlatform);
    
    add(InitializeEvent());
  }

  Future<void> _initPlatform(InitializeEvent event, Emitter<MakeDocumentState> emit) async {
    emit(InitialState());
    DateTime started = DateTime.now();
    String imagePath = join(await getStorageDir(),
        "${(started.millisecondsSinceEpoch ~/ 1000).round()}.jpeg");
    try {
      _checkPermission(emit);

      await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: false,
        androidScanTitle: strings.makeDocumentPageAndroidScan,
        androidCropTitle: strings.makeDocumentPageAndroidCropTitle,
        androidCropBlackWhiteTitle: strings.makeDocumentPageAndroidBWTitle,
        androidCropReset: strings.makeDocumentPageAndroidCropReset,
      );
    } on PlatformException catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(InitializeError());
      return;
    }

    if (await File(imagePath).exists()) {
      DateTime makedIn = DateTime.now();
      var file = File(imagePath);
      imagePath = join(
          await getStorageDir(),
          (makedIn.millisecondsSinceEpoch ~/ 1000).round().toString() +
              extension(imagePath));
      await file.rename(imagePath);

      String compressedImagePath = join(await getCompressedStorageDir(),
          "${(started.millisecondsSinceEpoch ~/ 1000).round()}.jpeg");

      final img.Image? capturedImage =
          img.decodeImage(await File(imagePath).readAsBytes());

      await File(compressedImagePath)
          .writeAsBytes(img.encodeJpg(capturedImage!, quality: 50));

      ReviewStepFileDTO stepFileDTO = ReviewStepFileDTO(
          stepId: step.localId,
          type: StepContentType.document.name,
          createdAt: makedIn.toUtc(),
          onDeviceCreatedAt: makedIn,
          path: imagePath,
          compressedPath: compressedImagePath,
          hash: await fileHashService.md5Hash(imagePath));

      emit(MakeDocumentToPreviewPhoto(stepFileDTO: stepFileDTO));
      return;
    }
    emit(ExitState());
  }

  _checkPermission(Emitter emit) async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      emit(MakeDocumentHaveNotLocationPermission());
      return;
    }
  }
}
