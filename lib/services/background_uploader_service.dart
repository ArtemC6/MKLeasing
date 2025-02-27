import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
// import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:leasing_company/api/ReviewService.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_location_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:throttling/throttling.dart';

import '../features/uploads/domain/repositories/upload_repository.dart';

Map<String, Debouncing> debs = {};

Map prefs = {};

Map<String, UploadTaskSt> tasks = {};

int progressEvents = 0;
int resultEvents = 0;
int streamEvents = 0;
int resolvedEvents = 0;

var streamController;

var uploadRepository = getIt<UploadRepository>();
var stepFileRepository = getIt<ReviewStepFileRepository>();
var locationRepository = getIt<ReviewLocationRepository>();
var reviewRepository = getIt<ReviewRepository>();

class UploadTaskSt {
  String taskId;
  TaskStatus status;
  int progress;

  UploadTaskSt(
      {required this.taskId, required this.status, required this.progress});
}

//@pragma('vm:entry-point')
void uploaderBackgroundHandler() async {
  print('uploaderBackgroundHandler');

  // WidgetsFlutterBinding.ensureInitialized();
  // DartPluginRegistrant.ensureInitialized();

 // tz.initializeTimeZones();

 // database = MyDatabase();
 //  uploadRepository = UploadRepositoryImpl();
 //  stepFileRepository = ReviewStepFileRepositoryImpl();
 //  locationRepository = ReviewLocationRepositoryImpl();
 //  reviewRepository = ReviewRepositoryImpl(
 //    locationRepository,
 //    stepFileRepository,
 //    uploadRepository,
 //    ReviewTemplateRepositoryImpl(
 //      ReviewTemplateStepRepositoryImpl(
 //        ReviewTemplateFormRepositoryImpl(),
 //        ReviewTemplateStepLocalDataSourceImpl(),
 //      ),
 //      ReviewTemplateRemoteDataSourceImpl(),
 //      ReviewTemplateLocalDataSourceImpl(),
 //      ReviewTemplateSectionRepositoryImpl(
 //        ReviewTemplateSectionLocalDataSourceImpl(),
 //      ),
 //    ),
 //    ReviewStepViolationRepositoryImpl(),
 //  );

  FileDownloader().updates.listen((update) {
    if (update is TaskStatusUpdate) {
      switch (update.status) {
        case TaskStatus.complete:
          // print('Задача ${update.task.taskId} успешно завершена!');

          progressEvent(update.status, update.task.taskId);

        case TaskStatus.canceled:
          // print('Загрузка отменена');

          progressEvent(update.status, update.task.taskId);

        case TaskStatus.paused:
          // print('Загрузка приостановлена');

          progressEvent(update.status, update.task.taskId);

        default:
          // print('Загрузка завершилась неудачно');
          progressEvent(update.status, update.task.taskId);
      }
    } else if (update is TaskProgressUpdate) {
      // Обрабатываем обновление прогресса задачи
      // progressUpdateStream.add(update); // Передаем обновление в виджет для индикатора
    }
  });

  streamController = StreamController<UploadTaskSt>.broadcast();
  streamController.stream.listen(streamUploadUpdateEvent);

  // uploader.progress.listen(progressEvent);
  //
  // uploader.result.listen(resultEvent);
}

progressEvent(TaskStatus progress, String taskId) async {
  progressEvents++;
  if (!tasks.containsKey(taskId)) {
    tasks[taskId] = new UploadTaskSt(
      taskId: taskId,
      status: progress,
      progress: 0,
    );
    streamController.add(tasks[taskId]!);
  }
  // else if (tasks[taskId]?.progress != progress.progress) {
  //   tasks[taskId]?.progress = progress.progress ?? 0;
  //   streamController.add(tasks[taskId]!);
  // }
}

// resultEvent(UploadTaskResponse result) async {
//   resultEvents++;
//   if (!tasks.containsKey(result.taskId)) {
//     tasks[result.taskId] = new UploadTaskSt(
//       taskId: result.taskId,
//       status: result.status ?? UploadTaskStatus.undefined,
//       progress: 0,
//     );
//     streamController.add(tasks[result.taskId]!);
//   } else if (tasks[result.taskId]?.status != result.status) {
//     tasks[result.taskId]?.status = result.status ?? UploadTaskStatus.undefined;
//     streamController.add(tasks[result.taskId]!);
//   }
// }

streamUploadUpdateEvent(UploadTaskSt uploadTaskSt) async {
  streamEvents++;

  if (!debs.containsKey(uploadTaskSt.taskId)) {
    debs[uploadTaskSt.taskId] = Debouncing(duration: Duration(seconds: 5));
  }

  debs[uploadTaskSt.taskId]!.debounce(() async {
    resolvedEvents++;

    try {
      DateTime? uploadedAt;

      if (uploadTaskSt.status == TaskStatus.complete) {
        uploadedAt = DateTime.now();
      }

      var upload = await uploadRepository.getByTaskId(uploadTaskSt.taskId);

      if (upload == null) {
        return;
      }

      await uploadRepository.update(uploadTaskSt.taskId,
          progress: uploadTaskSt.progress,
          // status: uploadTaskSt.status.value,
          status: 0,
          uploadedAt: uploadedAt);

      // Выход если это не завершение загрузки
      if (uploadTaskSt.status != TaskStatus.complete) {
        return;
      }

      Review? review;
      if (upload.entityAction == EntityAction.REVIEW_STORE.toString()) {
        review = await reviewRepository.getByUuid(upload.entityId);
        await reviewRepository.update(review!.uuid,
            startPointUploadedAt: DateTime.now());
      } else if (upload.entityAction ==
          EntityAction.REVIEW_INTERRUPT.toString()) {
        review = await reviewRepository.getByUuid(upload.entityId);
        await reviewRepository.update(review!.uuid,
            interruptPointUploadedAt: DateTime.now());
      } else if (upload.entityAction == EntityAction.REVIEW_FINISH.toString()) {
        review = await reviewRepository.getByUuid(upload.entityId);
        await reviewRepository.update(review!.uuid,
            finishedUploadedAt: DateTime.now());
      } else if (upload.entityAction ==
          EntityAction.ATTACH_COMMENTS.toString()) {
        review = await reviewRepository.getByUuid(upload.entityId);
        await reviewRepository.update(review!.uuid,
            commentsUploadedAt: DateTime.now());
      } else if (upload.entityAction ==
          EntityAction.ATTACH_DELETING_FILES.toString()) {
        review = await reviewRepository.getByUuid(upload.entityId);
        await reviewRepository.update(review!.uuid,
            deletingMediaUploadedAt: DateTime.now());
      } else if (upload.entityAction ==
          EntityAction.ATTACH_VIOLATIONS.toString()) {
        review = await reviewRepository.getByUuid(upload.entityId);
        await reviewRepository.update(review!.uuid,
            violationsUploadedAt: DateTime.now());
      } else if (upload.entityAction ==
          EntityAction.STEP_FILE_UPLOAD.toString()) {
        var stepFile = await stepFileRepository.getByUuid(upload.entityId);
        await stepFileRepository.update(stepFile!.uuid,
            uploadedAt: DateTime.now());
        review = await reviewRepository.getByUuid(stepFile.reviewUuid);
      } else if (upload.entityAction ==
          EntityAction.LOCATION_UPLOAD.toString()) {
        var location = await locationRepository.getByUuid(upload.entityId);
        await locationRepository.update(location!.uuid,
            uploadedAt: DateTime.now());
        review = await reviewRepository.getByUuid(location.reviewUuid);
      }

      if (review == null) {
        return;
      }

      bool finished = await reviewRepository.isFinished(review.uuid);

      if (finished == true) {
        // Если все составляющие отчета успешно были переданы на сервер,
        // то удаляем вложенные данные и сам отчет
        await reviewRepository.deleteWithChildren(review.uuid);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      print(exception);
      print(stackTrace);

      // повтор в случае возникновения ошибок
      await Future.delayed(Duration(seconds: 3));
      streamUploadUpdateEvent(uploadTaskSt);
    }
  });
}
