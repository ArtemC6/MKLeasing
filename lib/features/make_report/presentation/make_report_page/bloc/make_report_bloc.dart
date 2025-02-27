import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:disk_space_2/disk_space_2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leasing_company/api/ReviewService.dart';
import 'package:leasing_company/api/data_service.dart';
import 'package:leasing_company/core/config/models/config_model.dart';
import 'package:leasing_company/core/config/repositories/config_repository.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/core/managers/location_service.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/main/domain/repositories/notification_repository.dart';
import 'package:leasing_company/features/main/presentation/enums/notification_status.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_model.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_status.dart';
import 'package:leasing_company/features/make_report/presentation/review_template_form_step/page/review_template_form_step_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_form_field_type_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_type.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_location_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_violation_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_field_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/add_users_step_to_review_template.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/copy_section.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/create_copy_of_review_template.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_full_review_template.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_full_steps_for_review_template.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_review_template_by_remote_id.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_sections_for_review_template.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/update_step.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_model.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_status.dart';
import 'package:leasing_company/features/uploads/domain/repositories/upload_repository.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_hash_service.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:leasing_company/services/push_messaging_service.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:location/location.dart' as loc;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:throttling/throttling.dart';
import 'package:uuid/uuid.dart';

part 'make_report_event.dart';

part 'make_report_state.dart';

enum LocationPermissionEnum {
  NONE,
  HAVE_NOT_LOCATION_PERMISSION,
  LOCATION_SERVICE_DISABLED,
  READY,
  HAVE_NOT_LOCATION_HIGH_ACCURACY_PERMISSION,
  PERMISSION_GRANTED
}

class MakeReportBloc extends Bloc<MakeReportEvent, MakeReportState> {
  final GetCurrentCompany _getCurrentCompanyUseCase = getIt();
  final reviewRepository = getIt<ReviewRepository>();
  final articleRepository = getIt<ArticleRepository>();
  final reviewTemplateRepository = getIt<ReviewTemplateRepository>();
  final reviewTemplateStepRepository = getIt<ReviewTemplateStepRepository>();
  final reviewTemplateStepFormRepository = getIt<ReviewTemplateStepFormRepository>();
  final reviewTemplateStepFormFieldRepository = getIt<ReviewTemplateStepFormFieldRepository>();

  final reviewStepFileRepository = getIt<ReviewStepFileRepository>();
  final reviewLocationRepository = getIt<ReviewLocationRepository>();
  final reviewStepViolationRepository = getIt<ReviewStepViolationRepository>();
  final configRepository = getIt<ConfigRepository>();
  final uploadRepository = getIt<UploadRepository>();

  final reviewService = getIt<ReviewService>();
  final fileHashService = getIt<FileHashService>();
  final toastService = getIt<ToastService>();
  final dialogManager = getIt<DialogManager>();
  final locationService = getIt<LocationService>();
  final DataService _dataService = getIt();

  final pushMessagingService = getIt<PushMessagingService>();
  final _notificationRepository = getIt<NotificationRepository>();
  StreamSubscription<LocationData>? locationSubscription;

  LocationData? currentLocation;
  Throttling? locationSenderThrottle;

  String? cacheStorageDir;
  String? storageDir;
  String? compressedStorageDir;

  final CompanyEntity company;
  final int? taskRemoteId;
  final int? articleLocalId;
  final int articleRemoteId;
  ReviewTemplateModel originalTemplate;
  bool isLocationReaderStarted = false;

  late ReviewTemplateModel template;
  Review? review;
  Config? config;
  Article? article;
  List<StepModel>? steps;
  List<ReviewSection>? sections; // TODO: создать ReviewSectionEntity/Model
  List<ReviewTemplateStepFormModel>? forms;
  List<ReviewStepFile>? files; // TODO: создать ReviewStepFileEntity/Model
  List<ReviewStepViolation>? violations; // TODO: создать ReviewStepViolationEntity/Model
  bool isPageOpen = true;
  bool isInitialStartOfPage = true;
  bool isLocationAttached = false;
  List<ReviewModel> reviewList = [];
  CompanyEntity? _companyEntity;
  int currentStepIndex = 0;
  BuildContext context;

  MakeReportBloc({
    required this.company,
    this.taskRemoteId,
    required this.review,
    required this.articleLocalId,
    required this.articleRemoteId,
    required this.originalTemplate,
    required this.context,
  }) : super(MakeReportInitState()) {
    on<MakeReportInitEvent>(_init);
    on<MakeReportRefreshEvent>(_refresh);
    on<MakeReportPauseEvent>(_pause);
    on<MakeReportResumeEvent>(_resume);
    on<MakeReportLeaveEvent>(_leave);
    on<MakeReportFinishEvent>(_finish);
    on<MakeReportInterruptEvent>(_interrupt);
    on<MakeReportTakeMediaEvent>(_takeMedia);
    on<SingleFormChangedEvent>(_singleFormChanged);
    on<MakeReportChangeMediaCommentEvent>(_changeMediaComment);
    on<CreateNewStepsEvent>(_createNewStep);
    on<UpdateStepEvent>(_onUpdateStepEvent);
    on<CopySectionEvent>(_onCopySectionEvent);
    on<MakeReportChangeStepEvent>(_changeStep);
    on<MakeReportNextStepEvent>(_nextStep);
    on<MakeReportDeleteFileEvent>(_deleteFile);
    on<BackToStepsListPageEvent>(_onBackToStepsListPageEvent);
    on<MakeReportAddingMediaFileEvent>(_onMakeReportAddingMediaFileEvent);
    on<AddStepCheckBoxValueChangedEvent>(_onAddStepCheckBoxValueChangedEvent);
    on<EndButtonPressedEvent>(_onEndButtonPressedEvent);
    on<MakeReportLocationUndefinedEvent>(_onMakeReportLocationUndefinedEvent);
    on<MakeReportWithoutInitialLocationEvent>(_onMakeReportWithoutInitialLocationEvent);
    on<MakeReportRetryLocatingEvent>(_onMakeReportRetryLocatingEvent);
    on<MakeReportLocationDetectedEvent>(_onMakeReportLocationDetectedEvent);
    on<OnDatabaseInsertError>(_onDatabaseInsertError);
    on<MakeReportPreviewEvent>(_preview);
    on<GetToWorkOnPressesEvent>(_getToWorkOnPressesEvent);
  }

  @override
  Future<void> close() async {
    await _stopLocationServices();
    return super.close();
  }

  Future _reloadSteps() async {
    steps = (await getIt<GetFullStepsForReviewTemplate>().call(GetFullStepsForReviewTemplateParams(
      templateLocalId: template.localId!,
    )))
        .map((e) => StepModel(e))
        .toList();
  }

  Future _validateSteps({List<int>? excludeLocalIds}) async {
    steps = await Future.wait(steps!.map((step) async {
      if (excludeLocalIds != null && excludeLocalIds.contains(step.localId)) {
        return step;
      }

      return step.copyWithStepModel(
        stepStatus: await _validateStep(step),
      );
    }).toList());
  }

  Future<void> _init(MakeReportInitEvent event, Emitter<MakeReportState> emit) async {
    double freeDiskSpace = 0;
    try {
      freeDiskSpace = (await DiskSpace.getFreeDiskSpace)!;
    } on PlatformException {
      freeDiskSpace = 0;
    }

    if (freeDiskSpace < 1024) {
      emit(MakeReportNotEnoughDiskSpaceState(freeDiskSpace: freeDiskSpace));
      return;
    }

    await Future.wait([
      getCacheStorageDir().then((value) => cacheStorageDir = value),
      getCompressedStorageDir().then((value) => compressedStorageDir = value),
      getStorageDir().then((value) => storageDir = value),
      configRepository.get().then((value) => config = value),
    ]);

    // Первое открытие проверки?
    bool isFirstOpenReview = review == null;

    if (review != null) {
      template = await GetFullReviewTemplate().call(
        GetFullReviewTemplateParams(
          companyUuid: company.uuid,
          localId: originalTemplate.localId ?? 0,
        ),
      );
    } else {
      if (originalTemplate.steps == null || originalTemplate.sections == null) {
        originalTemplate = await GetReviewTemplateByRemoteId().call(
          GetReviewTemplateByRemoteIdParams(
            companyUuid: company.uuid,
            template: originalTemplate,
          ),
        );
      }
      template = originalTemplate;

      // Создаем копию шаблона, и на ее основе проходим шаблон.
      // Все изменения, вроде новых шагов и т.п фиксируются за копией шаблона, а не оригинальным шаблоном.
      int copyOfTemplateLocalId = await CreateCopyOfReviewTemplate().call(
        CreateCopyOfReviewTemplateParams(
          companyUuid: company.uuid,
          template: template,
        ),
      );

      template = await GetFullReviewTemplate().call(GetFullReviewTemplateParams(companyUuid: company.uuid, localId: copyOfTemplateLocalId));
      review = await reviewRepository.create(
        uuid: Uuid().v4(),
        companyUuid: company.uuid,
        taskRemoteId: taskRemoteId,
        templateId: template.localId!,
        remoteTemplateId: template.remoteId,
        articleId: this.articleLocalId,
        remoteArticleId: this.articleRemoteId,
        startedAt: DateTime.now().toUtc(),
        onDeviceStartedAt: DateTime.now(),
        offline: config!.isOffline,
      );
      try {
        await reviewService.store(review!.uuid);
      } catch (e) {
        print('Handled exception = $e');
      }
    }
    article = await articleRepository.getByRemoteId(
      company.uuid,
      review!.remoteArticleId,
    );
    steps = template.steps?.map((e) => StepModel(e)).toList();
    sections = template.sections;

    // Грузим/актуализируем отчет
    review = await reviewRepository.getByUuid(review!.uuid);

    await Future.wait([
      // получаем уже имеющиеся файлы
      reviewStepFileRepository.getForReview(review!.uuid).then((value) => files = value),

      // получаем уже имеющиеся отметки о нарушениях
      reviewStepViolationRepository.getForReview(review!.uuid).then((value) => violations = value),
    ]);

    forms = template.steps!.where((step) => step.form != null).map((e) => e.form).cast<ReviewTemplateStepFormModel>().toList();
    // Сортируем шаги
    steps!.sort((a, b) => a.weight.compareTo(b.weight));

    for (StepModel step in steps!) {
      steps![steps!.indexOf(step)] = step.copyWithStepModel(
        stepStatus: await _validateStep(step, isInitialCheck: isFirstOpenReview),
      );
    }

    await for (final LocationPermissionEnum lpe in locationPermissionHandler()) {
      print(lpe);
      if (lpe == LocationPermissionEnum.NONE && isInitialStartOfPage) {
        emit(MakeReportInitState());
      }

      if (lpe == LocationPermissionEnum.HAVE_NOT_LOCATION_PERMISSION ||
          lpe == LocationPermissionEnum.HAVE_NOT_LOCATION_HIGH_ACCURACY_PERMISSION ||
          lpe == LocationPermissionEnum.LOCATION_SERVICE_DISABLED) {
        print(lpe);

        emit(MakeReportError(lpe, locationService));
      }
      if (lpe == LocationPermissionEnum.READY) {
        if (locationSubscription == null && isPageOpen) {
          if (isInitialStartOfPage || (!(state is MakeReportLocationUndefinedState) && !(state is MakeReportReadyState))) {
            emit(MakeReportWaitLocationState((locationAccuracy) {
              changeAccuracyMode(locationAccuracy);
            }));
          }
          if (!isLocationReaderStarted) {
            _runLocationReader();
            isLocationReaderStarted = true;
          }
        }
        if (currentLocation != null &&
            !(state is MakeReportReadyState) &&
            !(state is MakeReportFinishState) &&
            !(state is MakeReportLeaveState) &&
            !(state is MakeReportNotEnoughDiskSpaceState) &&
            !(state is MakeReportSignState)) {
          emit(await makeReportReadyState());
          isInitialStartOfPage = false;
        }
      }
    }
  }

  Stream<LocationPermissionEnum> locationPermissionHandler() async* {
    yield LocationPermissionEnum.NONE;

    bool currentLocationServiceEnabled = false;
    while (!isClosed) {
      await Future.delayed(Duration(seconds: state is MakeReportReadyState ? 3 : 1));

      loc.PermissionStatus currentLocationPermission = await locationService.hasPermission();

      if (currentLocationPermission == loc.PermissionStatus.granted) {
        currentLocationServiceEnabled = await locationService.serviceEnabled();
        if (!currentLocationServiceEnabled) {
          // yield LocationPermissionEnum.LOCATION_SERVICE_DISABLED;
          currentLocationServiceEnabled = await locationService.requestService();
        }
      }

      if (currentLocationPermission == loc.PermissionStatus.denied ||
          (Platform.isAndroid && currentLocationPermission == loc.PermissionStatus.denied && await Permission.location.shouldShowRequestRationale == true)) {
        currentLocationPermission = await loc.Location().requestPermission();
      }

      /// The permission has been granted but for low accuracy. Only valid on iOS 14+.
      if (currentLocationPermission == loc.PermissionStatus.grantedLimited) {
        yield LocationPermissionEnum.HAVE_NOT_LOCATION_HIGH_ACCURACY_PERMISSION;
      }

      if (currentLocationPermission == loc.PermissionStatus.deniedForever ||
          (currentLocationPermission == loc.PermissionStatus.denied && await Permission.location.shouldShowRequestRationale == false)) {
        yield LocationPermissionEnum.HAVE_NOT_LOCATION_PERMISSION;
      }

      if (currentLocationPermission == loc.PermissionStatus.granted && currentLocationServiceEnabled) {
        yield LocationPermissionEnum.READY;
      }
    }
  }

  Future<MakeReportReadyState> makeReportReadyState({
    bool? isNeedDisplayStepsList,
    bool? isAddStepCheckBoxSelected,
  }) async {
    violations = await reviewStepViolationRepository.getForReview(review!.uuid);
    return MakeReportReadyState(
      review: review!,
      template: template,
      steps: steps!,
      forms: forms!,
      files: files!.where((element) => element.deletedByUserAt == null).toList(),
      violations: violations!,
      currentStepIndex: currentStepIndex,
      storageDir: storageDir!,
      cacheStorageDir: cacheStorageDir!,
      compressedStorageDir: compressedStorageDir!,
      canFinish: await _canFinish(),
      sections: sections,
      isNeedDisplayStepsList: isNeedDisplayStepsList == null
          ? state is MakeReportReadyState
              ? (state as MakeReportReadyState).isNeedDisplayStepsList
              : true
          : isNeedDisplayStepsList,
      isAddStepCheckBoxSelected: isAddStepCheckBoxSelected == null
          ? state is MakeReportReadyState
              ? (state as MakeReportReadyState).isAddStepCheckBoxSelected
              : false
          : isAddStepCheckBoxSelected,
    );
  }

  Future<void> _refresh(MakeReportRefreshEvent event, Emitter<MakeReportState> emit) async {
    emit(await makeReportReadyState());
  }

  _runLocationReader() {
    locationSenderThrottle = Throttling(duration: Duration(seconds: 15));
    locationSubscription = locationService.getLocationStream()?.listen((LocationData newLocation) async {
      //if location not changed
      if (currentLocation != null) {
        if (currentLocation!.latitude == newLocation.latitude &&
            currentLocation!.longitude == newLocation.longitude &&
            currentLocation!.accuracy == newLocation.accuracy) {
          return;
        }
      } else {
        if (!(state is MakeReportReadyState) &&
            !(state is MakeReportFinishState) &&
            !(state is MakeReportLeaveState) &&
            !(state is MakeReportNotEnoughDiskSpaceState)) {
          add(MakeReportLocationDetectedEvent(newLocation));
          isInitialStartOfPage = false;
        }
      }
      if (locationSenderThrottle != null && locationSenderThrottle!.isReady) {
        locationSenderThrottle?.throttle(() async {
          await attachLocation(newLocation);
        });
      }
      currentLocation = newLocation;
    });
  }

  Future<bool> attachLocation(LocationData location) async {
    if (location.longitude == null || location.latitude == null || location.accuracy == null) {
      return false;
    }
    final onDeviceCreatedAt = DateTime.now();
    final reviewLocation = await reviewLocationRepository.create(
      uuid: Uuid().v4(),
      latitude: location.latitude!,
      longitude: location.longitude!,
      accuracy: location.accuracy!,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
      gpsCreatedAt: location.time != null ? location.time! : onDeviceCreatedAt,
      reviewUuid: review!.uuid,
      mocked: location.isMock,
    );
    await reviewService.attachLocation(reviewLocation, review);
    return true;
  }

  Future _stopLocationServices() async {
    isPageOpen = false;
    locationService.close();
    await locationSubscription?.cancel();
    locationSubscription = null;
    await locationSenderThrottle?.close();
    locationSenderThrottle = null;
  }

// продолжить после сворачивания
  Future<void> _resume(MakeReportResumeEvent event, Emitter<MakeReportState> emit) async {
    _startUploadAllNotUploadedFiles();
    _runLocationReader();
    isPageOpen = true;
    isLocationAttached = false;
  }

  Future<void> _pause(MakeReportPauseEvent event, Emitter<MakeReportState> emit) async {
    currentLocation = null;

    await _stopLocationServices();
  }

  Future<void> _leave(MakeReportLeaveEvent event, Emitter<MakeReportState> emit) async {
    await Future.wait([
      _startUploadAllNotUploadedFiles(),
      _stopLocationServices(),
    ]);
    emit(MakeReportLeaveState());
    close();
  }

  Future<void> _takeMedia(MakeReportTakeMediaEvent event, Emitter<MakeReportState> emit) async {
    List<ReviewStepFileDTO>? stepFilesList;

    final step = steps!.firstWhere((element) => element.localId == event.stepId);

    if (step.type == ReviewTemplateStepType.form) {
      ReviewTemplateStepFormModel form = forms!.firstWhere((element) => element.localId == step.formId);
      final formResponse = await Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => ReviewTemplateFormStepPage(
            company: company,
            review: review!,
            step: step,
            form: form,
          ),
        ),
      );
      if (formResponse != null) {
        stepFilesList = List.from([formResponse]);
      }
    }

    if (stepFilesList == null) {
      return;
    }

    for (final stepFile in stepFilesList) {
      await createStepFile(
        stepId: step.localId!,
        type: stepFile.type!,
        path: stepFile.path,
        compressedPath: stepFile.compressedPath,
        comment: stepFile.comment,
        onDeviceCreatedAt: stepFile.onDeviceCreatedAt!,
        createdAt: stepFile.createdAt!,
      );
    }

    emit(await makeReportReadyState());
  }

  Future<void> _singleFormChanged(SingleFormChangedEvent event, Emitter<MakeReportState> emit) async {
    final step = steps!.firstWhere((step) => step.localId == event.stepLocalId);

    final stepFiles = files!.where((file) => file.stepId == event.stepLocalId).toList();

    final hasFile = stepFiles.where((file) => file.path != null).isNotEmpty;

    if (!hasFile) {
      final now = DateTime.now();
      DateTime onDeviceCreatedAt = DateTime.now();

      final path = join(await getStorageDir(), "${onDeviceCreatedAt.millisecondsSinceEpoch ~/ 1000}.json");

      await createStepFile(
        stepId: event.stepLocalId,
        path: path,
        type: step.type.name,
        onDeviceCreatedAt: DateTime.now(),
        createdAt: now.toUtc(),
      );
    }
    final file = files!.firstWhere((element) => element.stepId == event.stepLocalId && element.path != null);

    await File(file.path!).writeAsString(jsonEncode(event.rawForm), flush: true);

    emit(await makeReportReadyState());
  }

  Future<void> _createNewStep(CreateNewStepsEvent event, Emitter<MakeReportState> emit) async {
    final listSteps = event.listNewSteps.mapIndexed((index, step) {
      return ReviewTemplateStepModel(
        localId: null,
        remoteId: null,
        companyUuid: company.uuid,
        parentId: steps![event.stepIndex].localId,
        formId: step.formId,
        form: step.form,
        remoteUuid: Uuid().v4(),
        comment: step.comment,
        templateId: template.localId!,
        reviewUuid: review!.uuid,
        title: step.title,
        subtitle: step.subtitle,
        type: ReviewTemplateStepTypeExt.byKeyword(step.type),
        contentImage: step.contentImage,
        contentMask: step.contentMask,
        contentText: step.contentText,
        required: step.required,
        requiredCommentWhenSkipping: step.requiredCommentWhenSkipping,
        expandable: step.expandable,
        repeatable: step.repeatable,
        canHaveViolation: step.canHaveViolation,
        weight: steps![event.stepIndex].weight + 1 + index,
        isSelfCreated: true,
        multimedia: step.multimedia,
        sectionId: step.sectionId,
        localSectionId: step.localSectionId,
      );
    }).toList();

    var stepLocalIds = await getIt<AddUsersStepsToReviewTemplate>().call(listSteps);

    await _reloadSteps();
    await _validateSteps(excludeLocalIds: stepLocalIds);

    emit(await makeReportReadyState(isAddStepCheckBoxSelected: false));
  }

  Future<void> _finish(MakeReportFinishEvent event, Emitter<MakeReportState> emit) async {
    await _notificationRepository.saveLocalList(
      notificationStatus: LocalNotificationStatus.reportSending,
      reviewOrTaskTitle: template.name,
      isReview: event.isReview,
      objectTitle: article!.title,
    );
    final onDeviceFinishedAt = DateTime.now();

    _startUploadAllNotUploadedFiles(withForms: true);

    await reviewRepository.update(
      review!.uuid,
      onDeviceFinishedAt: onDeviceFinishedAt,
      finishedAt: onDeviceFinishedAt.toUtc(),
    );

    emit(MakeReportFinishState(repeatable: template.repeatable));

    await reviewService.finish(review!.uuid);
    await reviewService.attachComments(review!.uuid);
    await reviewService.attachViolations(review!.uuid);
    await reviewService.attachDeleting(review!.uuid);

    close();
  }

  Future<void> _startUploadAllNotUploadedFiles({bool? withForms}) async {
    final filesUuids = files!.where((f) => (withForms == true || withForms != true && f.type != ReviewTemplateStepType.form.name)).map((f) => f.uuid).toList();

    final uploads = await uploadRepository.getForStepFiles(filesUuids);

    final notUploadedFiles = files!.where((f) => uploads.where((u) => u.entityId == f.uuid).length == 0).toList();

    await Future.wait(
        notUploadedFiles.where((notUploadedFile) => filesUuids.contains(notUploadedFile.uuid)).map((stepFile) => reviewService.attachMedia(stepFile)));
  }

  Future<void> _changeStep(MakeReportChangeStepEvent event, Emitter<MakeReportState> emit) async {
    currentStepIndex = event.stepIndex;
    _startUploadAllNotUploadedFiles();
    emit(await makeReportReadyState(
      isNeedDisplayStepsList: false,
      isAddStepCheckBoxSelected: false,
    ));
  }

  Future<void> _nextStep(MakeReportNextStepEvent event, Emitter<MakeReportState> emit) async {
    final currentStep = steps![currentStepIndex];
    if (currentStep.type == ReviewTemplateStepType.form || currentStep.type == ReviewTemplateStepType.multimedia) {
      final stepFiles = files!.where((f) => f.stepId == currentStep.localId);
      if (stepFiles.isEmpty && !steps![currentStepIndex].required && steps![currentStepIndex].requiredCommentWhenSkipping) {
        String? comment = await dialogManager.showStepSkipDialog(event.context);
        if (comment != null && comment.isNotEmpty) {
          final now = DateTime.now();
          await createStepFile(
            comment: comment,
            type: currentStep.type == ReviewTemplateStepType.multimedia ? currentStep.multimedia!.first.stepContentType.name : currentStep.type.name,
            stepId: currentStep.localId!,
            createdAt: now.toUtc(),
            onDeviceCreatedAt: now,
          );
        } else
          return;
      }
    }
    if (currentStepIndex < steps!.length - 1) {
      _startUploadAllNotUploadedFiles();
      steps![currentStepIndex] = currentStep.copyWithStepModel(stepStatus: await _validateStep(currentStep));
      currentStepIndex++;
      emit(await makeReportReadyState(isAddStepCheckBoxSelected: false));
    }
  }

  Future<void> _interrupt(MakeReportInterruptEvent event, Emitter<MakeReportState> emit) async {
    DateTime onDeviceInterruptedAt = DateTime.now();

    await reviewRepository.update(
      review!.uuid,
      interruptedAt: onDeviceInterruptedAt.toUtc(),
      onDeviceInterruptedAt: onDeviceInterruptedAt,
    );

    await reviewService.interrupt(review!.uuid);
    await reviewService.attachComments(review!.uuid);
    await reviewService.attachViolations(review!.uuid);
    await reviewService.attachDeleting(review!.uuid);

    // add(UploadAllNotUploadedFilesEvent());
    await _notificationRepository.saveLocalList(
        notificationStatus: LocalNotificationStatus.reportDeletedByUser, reviewOrTaskTitle: template.name, isReview: true, objectTitle: article!.title);
    emit(MakeReportInterruptState());
    close();
  }

  Future<void> createStepFile({
    required int stepId,
    required String type,
    String? path,
    String? compressedPath,
    String? comment,
    required DateTime onDeviceCreatedAt,
    required DateTime createdAt,
  }) async {
    final file = await reviewStepFileRepository.create(
        companyUuid: company.uuid,
        reviewUuid: review!.uuid,
        stepId: stepId,
        comment: comment,
        type: type,
        path: path,
        compressedPath: compressedPath,
        hash: path != null ? await fileHashService.md5Hash(path) : null,
        onDeviceCreatedAt: onDeviceCreatedAt,
        createdAt: createdAt);

    files!.add(file);
  }

  Future<void> _changeMediaComment(MakeReportChangeMediaCommentEvent event, Emitter<MakeReportState> emit) async {
    final fileIndex = files!.indexWhere((element) => element.uuid == event.fileUuid);

    if (fileIndex >= 0) {
      await reviewStepFileRepository.update(event.fileUuid, comment: event.comment);
      files![fileIndex] = (await reviewStepFileRepository.getByUuid(event.fileUuid))!;
    }

    emit(await makeReportReadyState());
  }

  Future<bool> _canFinish() async {
    final futures = steps!.where((step) => step.type != ReviewTemplateStepType.info).toList().map<Future<bool>>((ReviewTemplateStepModel step) async {
      if (step.required == false) return true;

      if (step.required == true) {
        if (step.type == ReviewTemplateStepType.multimedia) {
          bool isContentValid = true;

          final stepFiles = files!.where((file) => file.stepId == step.localId && file.deletedByUserAt == null);

          step.multimedia?.forEach((element) {
            final files = stepFiles.where((file) => element.stepContentType.name == file.type).toList();
            final isRestrictionsRespected = files.length >=
                (element.multiple
                    ? element.minCount != 0
                        ? element.minCount
                        : 1
                    : 1);
            if (!isRestrictionsRespected) isContentValid = false;
          });
          return isContentValid;
        }

        if (step.type == ReviewTemplateStepType.form) {
          var files = this.files!.where((file) => file.stepId == step.localId);
          if (files.length == 0) return false;

          var futures = files.map((file) async {
            String strForm = await File(file.path!).readAsString();
            Map<String, dynamic> rawForm = jsonDecode(strForm);
            return _validateForm(step.form!, rawForm);
          }).toList();

          var finishedList = await Future.wait(futures);
          var finished = finishedList.where((isFinish) => isFinish == false).length == 0;
          return finished;
        }
      }
      return false;
    }).toList();

    var finishedList = await Future.wait(futures);
    return finishedList.where((isFinish) => isFinish == false).length == 0;
  }

  Future<StepStatus> _validateStep(StepModel step, {bool isInitialCheck = false, bool isPreview = false}) async {
    if (isPreview) {
      return StepStatus.awaitingExecution;
    } else {
      if (step.type == ReviewTemplateStepType.info) return isInitialCheck && files!.isEmpty ? StepStatus.awaitingExecution : StepStatus.valid;

      if (!step.required) {
        if (step.requiredCommentWhenSkipping) {
          final isStepSkippedWithComment = files!
              .where((file) =>
                  file.stepId == step.localId && file.deletedByUserAt == null && file.path == null && file.compressedPath == null && file.comment != null)
              .isNotEmpty;
          if (isStepSkippedWithComment) {
            return StepStatus.valid;
          }
        } else {
          return isInitialCheck ? StepStatus.awaitingExecution : StepStatus.valid;
        }
      }
      if (step.type == ReviewTemplateStepType.multimedia) {
        bool isContentValid = true;

        final stepFiles = files!.where((file) => file.stepId == step.localId && file.deletedByUserAt == null);

        step.multimedia?.forEach((element) {
          final files = stepFiles.where((file) => element.stepContentType.name == file.type).toList();
          final isRestrictionsRespected = files.length >=
              (element.multiple
                  ? element.minCount != 0
                      ? element.minCount
                      : 1
                  : 1);
          if (!isRestrictionsRespected && step.required) isContentValid = false;
        });

        if (isInitialCheck) {
          return StepStatus.awaitingExecution;
        } else {
          return isContentValid
              ? StepStatus.valid
              : isInitialCheck
                  ? StepStatus.awaitingExecution
                  : StepStatus.notValid;
        }
      }

      if (step.type == ReviewTemplateStepType.form) {
        final files = this.files!.where((file) => file.stepId == step.localId && file.path != null);
        if (files.isEmpty) return isInitialCheck ? StepStatus.awaitingExecution : StepStatus.notValid;

        final futures = files.map((file) async {
          String strForm = await File(file.path!).readAsString();
          Map<String, dynamic> rawForm = jsonDecode(strForm);
          return _validateForm(step.form!, rawForm);
        }).toList();

        final finishedList = await Future.wait(futures);
        final finished = finishedList.where((isFinish) => isFinish == false).isEmpty;
        return finished
            ? StepStatus.valid
            : isInitialCheck
                ? StepStatus.awaitingExecution
                : StepStatus.notValid;
      }
      return StepStatus.notValid;
    }
  }

  _validateForm(ReviewTemplateStepFormModel form, Map<String, dynamic> rawForm) {
    var fieldsFinished = form.fields!.map((field) {
      if (field.properties.required == true) {
        if (field.type!.keyword == ReviewTemplateFormFieldType.hint) {
          return true;
        } else if (rawForm.containsKey(field.slug)) {
          if ([
            ReviewTemplateFormFieldType.text,
            ReviewTemplateFormFieldType.number,
            ReviewTemplateFormFieldType.date,
            ReviewTemplateFormFieldType.radiobutton,
            ReviewTemplateFormFieldType.select,
          ].contains(field.type!.keyword)) {
            return rawForm[field.slug] != null && rawForm[field.slug] != "";
          } else if ([
            ReviewTemplateFormFieldType.select,
          ].contains(field.type!.keyword)) {
            return rawForm[field.slug] != null;
          }
        } else
          return false;
      } else
        return true;
    });

    return fieldsFinished.where((isFinish) => isFinish == false).length == 0;
  }

  Future<void> _deleteFile(MakeReportDeleteFileEvent event, Emitter<MakeReportState> emit) async {
    await reviewStepFileRepository.deleteByUuid(event.file.uuid);
    files!.remove(event.file);

    add(MakeReportRefreshEvent());
  }

  Future changeAccuracyMode(CustomLocationAccuracy locationAccuracy) async {
    await locationSubscription?.cancel();
    locationSubscription = null;
    await locationService.changeSettings(locationAccuracy);
    _runLocationReader();
  }

  Future<void> _onBackToStepsListPageEvent(_, Emitter emit) async {
    emit(await makeReportReadyState(isNeedDisplayStepsList: true));
  }

  Future<FutureOr<void>> _onAddStepCheckBoxValueChangedEvent(AddStepCheckBoxValueChangedEvent event, Emitter<MakeReportState> emit) async {
    emit(await makeReportReadyState(isAddStepCheckBoxSelected: event.value));
  }

  Future<void> _onEndButtonPressedEvent(
    EndButtonPressedEvent event,
    Emitter emit,
  ) async {
    final currentStep = steps![currentStepIndex];
    if ((currentStep.type == ReviewTemplateStepType.form || currentStep.type == ReviewTemplateStepType.multimedia) &&
        !(state as MakeReportReadyState).isNeedDisplayStepsList) {
      final stepFiles = files!.where((f) => f.stepId == currentStep.localId);
      if (stepFiles.isEmpty && !steps![currentStepIndex].required && steps![currentStepIndex].requiredCommentWhenSkipping) {
        String? comment = await dialogManager.showStepSkipDialog(event.context);
        if (comment != null && comment.isNotEmpty) {
          final now = DateTime.now();
          await createStepFile(
            comment: comment,
            type: currentStep.type == ReviewTemplateStepType.multimedia ? currentStep.multimedia!.first.stepContentType.name : currentStep.type.name,
            stepId: currentStep.localId!,
            createdAt: now.toUtc(),
            onDeviceCreatedAt: now,
          );
        } else
          return;
      }
    }

    for (int i = 0; i < steps!.length; i++) {
      steps![i] = steps![i].copyWithStepModel(
        stepStatus: await _validateStep(steps![i]),
      );
    }
    if (steps!.where((element) => element.stepStatus == StepStatus.notValid).isEmpty) {
      if (template.simpleSignatureEnabled != true) {
        add(MakeReportFinishEvent(true));
        print('Finish');

        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          print('Нет подключения к интернету');
          Navigator.of(event.context).pop();
          Navigator.pushNamedAndRemoveUntil(event.context, '/home', (route) => true);
        }
      } else {
        emit(MakeReportSignState(template.simpleSignatureFile));
        return;
      }
    } else {
      emit(await makeReportReadyState());
      dialogManager.showInfoDialog(
        event.context,
        S.of(event.context).notAllStepsHaveBeenCompleted,
      );
    }
  }

  Future _onMakeReportLocationUndefinedEvent(_, Emitter emit) async {
    await locationSubscription?.cancel();
    locationService.close();
    isLocationReaderStarted = false;
    emit(MakeReportLocationUndefinedState());
  }

  Future _onMakeReportRetryLocatingEvent(_, Emitter emit) async {
    await changeAccuracyMode(CustomLocationAccuracy.high);
    emit(MakeReportWaitLocationState((locationAccuracy) {
      changeAccuracyMode(locationAccuracy);
    }));
    locationSubscription = null;
    _runLocationReader();
  }

  Future<void> _onMakeReportLocationDetectedEvent(MakeReportLocationDetectedEvent event, Emitter emit) async {
    await attachLocation(event.newLocation);
    emit(await makeReportReadyState());
  }

  Future<void> _onMakeReportAddingMediaFileEvent(
    MakeReportAddingMediaFileEvent event,
    Emitter emit,
  ) async {
    for (final stepFile in event.stepFiles) {
      await createStepFile(
        stepId: stepFile.stepId!,
        type: stepFile.type!,
        path: stepFile.path,
        compressedPath: stepFile.compressedPath,
        comment: stepFile.comment,
        onDeviceCreatedAt: stepFile.onDeviceCreatedAt!,
        createdAt: stepFile.createdAt!,
      );
    }
    emit(await makeReportReadyState());
  }

  Future _onCopySectionEvent(CopySectionEvent event, Emitter emit) async {
    final sectionSteps = event.section.isSelfCreated
        ? steps!.where((step) => step.localSectionId == event.section.id).toList()
        : steps!.where((step) => step.sectionId == event.section.remoteId).toList();
    var sectionLocalId = await getIt<CopySectionUseCase>().call(event.section, sectionSteps);

    await _reloadSteps();

    var stepsLocalIds = steps!.where((e) => e.localSectionId == sectionLocalId).map((e) => e.localId!).toList();

    await _validateSteps(excludeLocalIds: stepsLocalIds);

    sections = await getIt<GetSectionsForReviewTemplate>().call(template.localId!);

    emit(await makeReportReadyState(isAddStepCheckBoxSelected: false));
  }

  Future<void> _onUpdateStepEvent(UpdateStepEvent event, Emitter emit) async {
    await getIt<UpdateStepUseCase>().call(event.updatedStep);

    await _reloadSteps();
    await _validateSteps();

    emit(await makeReportReadyState(isAddStepCheckBoxSelected: false));
  }

  Future<void> _onDatabaseInsertError(OnDatabaseInsertError event, Emitter emit) async {
    await reviewRepository.deleteWithChildren(event.uuid);
    try {
      await _dataService.syncAllData();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
    _companyEntity = await _getCurrentCompanyUseCase();

    final articles = await articleRepository.getListForCompany(_companyEntity!.uuid);

    final reviews = await reviewRepository.getInProgressReviews(_companyEntity!.uuid, articles.map((e) => e.remoteId).toList());

    final templates = (await reviewTemplateRepository.getListForArticles(_companyEntity!.uuid, articles.map((e) => e.id).toList()))
        .where((element) => element.private)
        .toList();
    templates.sort((a, b) => a.remoteId.compareTo(b.remoteId));

    final templateToArticles = await reviewTemplateRepository.getReviewTemplatesToArticlesList(_companyEntity!.uuid, articles.map((e) => e.id).toList());

    final List<ReviewModel> reviewModelsList = [];

    for (ReviewTemplate template in templates) {
      final articleId = templateToArticles.firstWhere((e) => e.templateId == template.id).articleId;

      final remoteArticleId = articles.firstWhere((article) => article.id == articleId).remoteId;

      final startedReviewsForTemplate = reviews.where((review) => template.remoteId == review.remoteTemplateId).toList();

      if (startedReviewsForTemplate.isEmpty) {
        reviewModelsList.add(ReviewModel(
          article: articles.where((article) => article.remoteId == remoteArticleId).first,
          reviewTemplate: template,
          status: ReviewStatus.scheduled,
          review: null,
        ));
      }

      for (Review review in reviews) {
        final reviewTemplate = await reviewTemplateRepository.getById(_companyEntity!.uuid, review.templateId);
        if (reviewTemplate != null) {
          reviewModelsList.add(ReviewModel(
            article: articles.where((article) => article.remoteId == review.remoteArticleId).first,
            reviewTemplate: reviewTemplate,
            status: ReviewStatus.inWork,
            review: review,
          ));
        }
      }
      reviewList = reviewModelsList;

      emit(MakeReportDatabaseRefreshState(
        reviews: reviewList,
        companyEntity: _companyEntity!,
      ));
      event.completer?.complete();
    }
  }

  Future<void> _preview(MakeReportPreviewEvent event, Emitter<MakeReportState> emit) async {
    await Future.wait([
      configRepository.get().then((value) => config = value),
    ]);

    // Первое открытие проверки?
    if (originalTemplate.steps == null || originalTemplate.sections == null) {
      originalTemplate = await GetReviewTemplateByRemoteId().call(
        GetReviewTemplateByRemoteIdParams(
          companyUuid: company.uuid,
          template: originalTemplate,
        ),
      );
    }
    template = originalTemplate;

    steps = template.steps?.map((e) => StepModel(e)).toList();
    sections = template.sections;

    // Сортируем шаги
    steps!.sort((a, b) => a.weight.compareTo(b.weight));

    for (StepModel step in steps!) {
      steps![steps!.indexOf(step)] = step.copyWithStepModel(
        stepStatus: await _validateStep(step, isInitialCheck: true, isPreview: true),
      );
    }

    emit(MakeReportPreviewState(template: template, steps: steps!, currentStepIndex: currentStepIndex, sections: sections));
  }

  Future<void> _getToWorkOnPressesEvent(GetToWorkOnPressesEvent event, Emitter<MakeReportState> emit) async {
    bool available;
    try {
      available = await reviewTemplateRepository.checkAvailability(template.remoteId, company.uuid);
    } catch (exception, stackTrace) {
      available = true;
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
    if (available)
      await _notificationRepository.saveLocalList(
          notificationStatus: LocalNotificationStatus.gotToWork, reviewOrTaskTitle: event.reviewOrTaskTitle, isReview: true, objectTitle: event.objectTitle);
    emit(GotToWorkState(available: available));
  }

  FutureOr<void> _onMakeReportWithoutInitialLocationEvent(_, Emitter<MakeReportState> emit) async {
    emit(await makeReportReadyState());
  }
}
