import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/api/ReviewService.dart';
import 'package:leasing_company/core/config/models/config_model.dart';
import 'package:leasing_company/core/config/repositories/config_repository.dart';
import 'package:leasing_company/features/authentication/domain/models/user_repository_response_models.dart';
import 'package:leasing_company/features/authentication/domain/repositories/user_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_location_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/features/uploads/domain/repositories/upload_repository.dart';
import 'package:leasing_company/services/file_export_service.dart';
import 'package:leasing_company/services/platform_service.dart';
import 'package:leasing_company/services/push_messaging_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'loading_event.dart';
import 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  final FileExportService _fileExportService;
  final ConfigRepository _configRepository;
  final UserRepository _userRepository;
  final PushMessagingService _pushMessagingService;
  final ReviewService _reviewService;
  final PlatformInfo _platformInfo;
  final ReviewRepository _reviewRepository;
  final ReviewLocationRepository _reviewLocationRepository;
  final ReviewStepFileRepository _reviewStepFileRepository;
  final UploadRepository _uploadRepository;

  bool? hasFilesForExport;

  LoadingBloc(
    this._reviewRepository,
    this._reviewLocationRepository,
    this._reviewStepFileRepository,
    this._platformInfo,
    this._fileExportService,
    this._configRepository,
    this._userRepository,
    this._pushMessagingService,
    this._reviewService,
    this._uploadRepository,
  ) : super(LoadingInProgressState()) {
    on<LoadingAppStartEvent>(_onStarted);
    on<LoadingRefreshEvent>(_onRefreshed);
    on<LoadingExportFilesFromStorageEvent>(_onFileExport);

    add(LoadingAppStartEvent());
  }

  Future<void> _onStarted(
      LoadingEvent event, Emitter<LoadingState> emit) async {
    try {
      // find files for export
      try {
        hasFilesForExport = await _fileExportService.hasFilesForExport();
      } catch (exception, stackTrace) {
        hasFilesForExport = false;
        print(exception);
        print(stackTrace);
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }

      // init push notifications
      try {
        _pushMessagingService.init();
      } catch (exception, stackTrace) {
        print(exception);
        print(stackTrace);
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }

      // request background permission on android
      try {
        if (Platform.isAndroid) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          if (androidInfo.version.sdkInt >= 23) {
            await Permission.ignoreBatteryOptimizations.request();
            //await OptimizationBattery.isIgnoringBatteryOptimizations();
            // await BatteryOptimization
            //     .openBatteryOptimizationSettings(); // TODO: test it
          }
        }
      } catch (exception, stackTrace) {
        print(exception);
        print(stackTrace);
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }

      // check network and load configuration from remote server
      Config? config;
      try {
        config = await this._configRepository.get(force: true);
      } on ServerIsNotAvailableAndHaveNotCacheOfConfig catch (exception) {
        emit(LoadingFailureState(
          platformInfo: _platformInfo,
          hasFilesForExport: hasFilesForExport!,
          errorMessage: exception.message,
          description:
              'Не удалось подключиться к серверу, кэш для работы оффлайн отсутствует.',
        ));
        return;
      } catch (exception, stackTrace) {
        print(exception);
        print(stackTrace);
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }

      final bool hasToken = await _userRepository.hasToken();
      // Если оффлайн
      if (config?.isOffline == true) {
        if (hasToken) {
          emit(LoadingAuthenticatedState());
        } else {
          emit(LoadingFailureState(
              platformInfo: _platformInfo,
              hasFilesForExport: hasFilesForExport!,
              description:
                  'Не удалось войти в оффлайн режим, данные об авторизации отсутствуют.'));
          return;
        }
      }

      if (config?.access == false) {
        emit(LoadingVersionFailureState(platformInfo: _platformInfo));
        return;
      }

      if (hasToken == false) {
        emit(LoadingUnauthenticatedState());
      } else {
        try {
          final MeResponse userResponse = await _userRepository.me();

          if (userResponse is SuccessMeResponse) {
            await _userRepository.setToken();
            await _userRepository.saveUser(userResponse.user);

            emit(LoadingAuthenticatedState()); // go to home
          } else {
            emit(LoadingUnauthenticatedState()); // go to login
          }
        } catch (exception, stackTrace) {
          print(exception);
          print(stackTrace);
          await Sentry.captureException(
            exception,
            stackTrace: stackTrace,
          );
        }

        try {
          final reviews = await _reviewRepository.getFullUploaded();

          await Future.wait(reviews.map((review) async {
            if (await _reviewRepository.isFinished(review.uuid) == true) {
              await _reviewRepository.deleteWithChildren(review.uuid);
            }
          }));
        } catch (exception, stackTrace) {
          await Sentry.captureException(
            exception,
            stackTrace: stackTrace,
          );
          print(exception);
          print(stackTrace);
        }

        try {
          // reload uploads
          if (hasToken == true) {
            await _uploadRepository.deleteAll();
            final reviewsForStore =
                await _reviewRepository.getStartedNotUploaded();
            await Future.wait(
                reviewsForStore.map((e) => _reviewService.store(e.uuid)));

            final reviewsForInterrupt =
                await _reviewRepository.getInterruptedNotUploaded();

            await Future.wait(reviewsForInterrupt
                .map((e) => _reviewService.interrupt(e.uuid)));

            final reviewsForFinished =
                await _reviewRepository.getNotFinishedUploaded();
            await Future.wait(
                reviewsForFinished.map((e) => _reviewService.finish(e.uuid)));

            final reviewsForAttachingComments =
                await _reviewRepository.getNotAttachedComments();
            await Future.wait(reviewsForAttachingComments
                .map((e) => _reviewService.attachComments(e.uuid)));

            final reviewsForAttachingViolations =
                await _reviewRepository.getNotAttachedViolations();
            await Future.wait(reviewsForAttachingViolations
                .map((e) => _reviewService.attachViolations(e.uuid)));

            final reviewsForAttachingDeletingMedia =
                await _reviewRepository.getNotAttachedDeletingMedia();
            await Future.wait(reviewsForAttachingDeletingMedia
                .map((e) => _reviewService.attachDeleting(e.uuid)));

            final filesNotUploaded =
                await _reviewStepFileRepository.getNotUploaded();
            await Future.wait(
                filesNotUploaded.map((e) => _reviewService.attachMedia(e)));

            final locationsNotUploaded =
                await _reviewLocationRepository.getNotUploaded();
            await Future.wait(locationsNotUploaded
                .map((e) => _reviewService.attachLocation(e)));

            final notFinishedUploads = await _uploadRepository.getNotUploaded();

            int index = 0;
            emit(LoadingReloadingTasksState(
              count: notFinishedUploads.length,
              progress: index,
            ));
            for (var upload in notFinishedUploads) {
              try {
                if (upload.entityAction ==
                    EntityAction.REVIEW_STORE.toString()) {
                  var review =
                      (await _reviewRepository.getByUuid(upload.reviewUuid))!;
                  await _reviewService.store(review.uuid);
                } else if (upload.entityAction ==
                    EntityAction.REVIEW_INTERRUPT.toString()) {
                  var review =
                      (await _reviewRepository.getByUuid(upload.reviewUuid))!;
                  await _reviewService.interrupt(review.uuid);
                } else if (upload.entityAction ==
                    EntityAction.REVIEW_FINISH.toString()) {
                  var review =
                      (await _reviewRepository.getByUuid(upload.reviewUuid))!;
                  await _reviewService.finish(review.uuid);
                } else if (upload.entityAction ==
                    EntityAction.STEP_FILE_UPLOAD.toString()) {
                  var stepFile = (await _reviewStepFileRepository
                      .getByUuid(upload.entityId))!;
                  await _reviewService.attachMedia(stepFile);
                } else if (upload.entityAction ==
                    EntityAction.LOCATION_UPLOAD.toString()) {
                  var location = (await _reviewLocationRepository
                      .getByUuid(upload.entityId))!;
                  await _reviewService.attachLocation(location);
                } else if (upload.entityAction ==
                    EntityAction.ATTACH_COMMENTS.toString()) {
                  await _reviewService.attachComments(upload.entityId);
                } else if (upload.entityAction ==
                    EntityAction.ATTACH_VIOLATIONS.toString()) {
                  await _reviewService.attachViolations(upload.entityId);
                } else if (upload.entityAction ==
                    EntityAction.ATTACH_DELETING_FILES.toString()) {
                  await _reviewService.attachDeleting(upload.entityId);
                } else {
                  throw Exception('Undefined entityAction');
                }
                await _uploadRepository.delete(upload.taskId);

                index++;
                emit(LoadingReloadingTasksState(
                  count: notFinishedUploads.length,
                  progress: index,
                ));
                await Future.delayed(Duration(milliseconds: 250));
              } catch (exception, stackTrace) {
                print(exception);
                print(stackTrace);
                await Sentry.captureException(
                  exception,
                  stackTrace: stackTrace,
                );
              }
            }
            emit(LoadingReloadingTasksState(
              count: notFinishedUploads.length,
              progress: index,
              finish: true,
            ));
          }
        } catch (exception, stackTrace) {
          print(exception);
          print(stackTrace);
          await Sentry.captureException(
            exception,
            stackTrace: stackTrace,
          );
        }
      }
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(LoadingFailureState(
          platformInfo: _platformInfo,
          hasFilesForExport: hasFilesForExport!,
          description: 'Глобальная неопознанная ошибка.'));
    }
  }

  Future<void> _onRefreshed(
      LoadingRefreshEvent event, Emitter<LoadingState> emit) async {
    try {
      add(LoadingAppStartEvent());
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(LoadingFailureState(
          platformInfo: _platformInfo,
          hasFilesForExport: hasFilesForExport!,
          description:
              'Неопознанная ошибки при повторной попытке загрузить приложение.'));
    }
  }

  Future<void> _onFileExport(LoadingExportFilesFromStorageEvent event,
      Emitter<LoadingState> emit) async {
    try {
      Stream<ExportProgress> stream = _fileExportService.exportToZip();
      emit(LoadingExportFilesFromStorageState(stream));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(LoadingFailureState(
        platformInfo: _platformInfo,
        hasFilesForExport: hasFilesForExport!,
        description: 'Неопознанная ошибка при выгрузке файлов из кэша.',
      ));
    }
  }
}
