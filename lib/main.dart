import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_udid/flutter_udid.dart';
// import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:leasing_company/api/ArticleService.dart';
import 'package:leasing_company/api/custom_http_overrides.dart';
import 'package:leasing_company/api/data_service.dart';
import 'package:leasing_company/app.dart';
import 'package:leasing_company/core/config/repositories/config_repository.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/core/managers/location_service.dart';
import 'package:leasing_company/features/articles/data/data_sources/article_remote_data_source.dart';
import 'package:leasing_company/features/articles/data/data_sources/data_sources_impl/article_remote_data_source_impl.dart';
import 'package:leasing_company/features/articles/data/repositories_impl/article_repository_impl.dart';
import 'package:leasing_company/features/articles/data/repositories_impl/article_type_repository_impl.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_type_repository.dart';
import 'package:leasing_company/features/authentication/data/repositories_impl/user_repository_impl.dart';
import 'package:leasing_company/features/authentication/domain/repositories/user_repository.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/managers/camera_file_manager.dart';
import 'package:leasing_company/features/company/data/repositories_impl/company_repository_impl.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/help/data/repositories_impl/help_question_repository_impl.dart';
import 'package:leasing_company/features/help/domain/repositories/help_question_repository.dart';
import 'package:leasing_company/features/home/services/reviews_count_service.dart';
import 'package:leasing_company/features/main/data/repositories_impl/notification_repository_impl.dart';
import 'package:leasing_company/features/main/domain/models/notification_model.dart';
import 'package:leasing_company/features/main/domain/models/notification_status_model.dart';
import 'package:leasing_company/features/main/domain/repositories/notification_repository.dart';
import 'package:leasing_company/features/main/domain/use_cases/change_company_use_case.dart';
import 'package:leasing_company/features/main/domain/use_cases/get_companies_use_case.dart';
import 'package:leasing_company/features/main/domain/use_cases/get_notifications_use_case.dart';
import 'package:leasing_company/features/make_report/data/repositories_impl/reject_delegate_repository_impl.dart';
import 'package:leasing_company/features/make_report/domain/repositories/reject_delegate_repository.dart';
import 'package:leasing_company/features/registration/data/repositories_impl/sign_up_repository_impl.dart';
import 'package:leasing_company/features/registration/domain/repositories/sign_up_repository.dart';
import 'package:leasing_company/features/reviews/data/data_sources/data_sources_impl/review_template_local_data_source_impl.dart';
import 'package:leasing_company/features/reviews/data/data_sources/data_sources_impl/review_template_remote_data_source_impl.dart';
import 'package:leasing_company/features/reviews/data/data_sources/data_sources_impl/review_template_section_local_data_source_impl.dart';
import 'package:leasing_company/features/reviews/data/data_sources/data_sources_impl/review_template_step_form_field_local_data_source_impl.dart';
import 'package:leasing_company/features/reviews/data/data_sources/data_sources_impl/review_template_step_form_local_data_source_impl.dart';
import 'package:leasing_company/features/reviews/data/data_sources/data_sources_impl/review_template_step_local_data_source_impl.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_local_data_source.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_remote_data_source.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_section_local_data_source.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_form_field_local_data_source.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_form_local_data_source.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_local_data_source.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_location_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_step_file_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_step_violation_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_form_field_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_form_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_section_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_step_form_field_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_step_form_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_step_repository_impl.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_location_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_violation_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_form_field_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_form_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_section_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_field_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/add_users_step_to_review_template.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/copy_section.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_full_steps_for_review_template.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_sections_for_review_template.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/update_step.dart';
import 'package:leasing_company/features/tasks/data/datasources/datasources_impl/task_remote_datasource_impl.dart';
import 'package:leasing_company/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:leasing_company/features/tasks/data/repositories_impl/task_repository_impl.dart';
import 'package:leasing_company/features/tasks/domain/repositories/task_repository.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/change_status.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/create_task.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_article_type_by_id.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_articles_by_type.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_list_review_templates.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_started_review_for_task.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_task_by_id.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/update_task.dart';
import 'package:leasing_company/features/uploads/data/repositories_impl/upload_repository_impl.dart';
import 'package:leasing_company/features/uploads/domain/repositories/upload_repository.dart';
import 'package:leasing_company/services/background_uploader_service.dart';
import 'package:leasing_company/services/file_export_service.dart';
import 'package:leasing_company/services/file_hash_service.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:leasing_company/services/platform_service.dart';
import 'package:location/location.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'api/DadataService.dart';
import 'api/api.dart';
import 'api/services.dart';
import 'core/managers/permission_manager.dart';
import 'features/tasks/domain/use_cases/get_articles_count_by_company.dart';
import 'firebase_options.dart';
import 'services/toast_service.dart';

late MyDatabase database;

final newVersion = NewVersionPlus(iOSAppStoreCountry: Api.iOSAppStoreCountry);

GetIt getIt = GetIt.instance;

Future<dynamic> notificationBackgroundHandler(RemoteMessage message) async {}

FutureOr<SentryEvent?> beforeSend(SentryEvent event, {dynamic hint}) async {
  if (event.throwable is SocketException || event.throwable is ServerIsNotAvailableAndHaveNotCacheOfConfig) {
    return null;
  }
  return event;
}

void main() async {
  HttpOverrides.global = new CustomHttpOverrides();
  kDebugMode
      ? _appRunner()
      : await SentryFlutter.init(
          (options) {
            options.dsn = 'https://624dfee0695140b3b7910e15783a9451@dev.sentry.check-up-online.ru/1';
            options.tracesSampleRate = 1.0;
            // options.beforeSend = beforeSend;
            options.addIntegration(LoggingIntegration());
          },
          appRunner: _appRunner,
        );
  Sentry.configureScope((scope) async => scope.setTag('user_device_udid', await FlutterUdid.udid));
}

Future<void> _appRunner() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(
      Duration(microseconds: 300), () => FlutterNativeSplash.remove());

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  database = MyDatabase();

  await Hive.initFlutter();
  Hive.registerAdapter(NotificationModelAdapter());
  Hive.registerAdapter(NotificationStatusModelAdapter());
  Box hiveAppBox = await Hive.openBox('appBox');
  SharedPreferences? sharedPreferences;

  await Future.wait([
    getStorageDir().then((value) => Directory(value).create()),
    getCompressedStorageDir().then((value) => Directory(value).create()),
    getCacheStorageDir().then((value) => Directory(value).create()),
    Firebase.initializeApp(),
    SharedPreferences.getInstance().then((value) => sharedPreferences = value),
  ]);

  tz.initializeTimeZones();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  Platform.isAndroid
      ? DeviceInfoPlugin().androidInfo.then((value) => Api.deviceModel = value.model)
      : DeviceInfoPlugin().iosInfo.then((value) => Api.deviceModel = value.model!);

  getIt.registerSingleton(packageInfo);

  getIt.registerSingleton(sharedPreferences!);

  getIt.registerSingleton(hiveAppBox, instanceName: 'AppBox');

  getIt.registerSingleton<Location>(Location());
  // getIt.registerSingleton<FlutterUploader>(FlutterUploader());
  getIt.registerLazySingleton(() => PermissionManager());
  getIt.registerLazySingleton(() => CameraFileManager());
  getIt.registerLazySingleton(() => DialogManager());

  // FlutterUploader flutterUploader = getIt.get<FlutterUploader>();

  // await Future.wait([
  //   flutterUploader.clearUploads(),
  //   flutterUploader.cancelAll(),
  //   //   flutterUploader.setBackgroundHandler(uploaderBackgroundHandler), // oops, not working on flutter 3.3.x+
  // ]);

  //await FlutterIsolate.spawn(uploaderBackgroundHandler, 'start');
  uploaderBackgroundHandler();

  getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
  getIt.registerSingleton<FlutterLocalNotificationsPlugin>(FlutterLocalNotificationsPlugin());
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    Api.notificationsChannelId,
    Api.notificationsChannelName,
    channelDescription: Api.notificationsChannelDescription,
    playSound: true,
    importance: Importance.max,
    priority: Priority.high,
    enableVibration: true,
    enableLights: true,
  );
  var iOSPlatformChannelSpecifics = new DarwinNotificationDetails(
    presentBadge: true,
    presentAlert: true,
    presentSound: true,
  );
  getIt.registerSingleton<NotificationDetails>(NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics));

  getIt.get<FlutterLocalNotificationsPlugin>().cancelAll();

  getIt.registerSingleton<ToastService>(ToastService());

  getIt.registerSingleton<ConfigService>(ConfigService());
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerSingleton<ArticleService>(ArticleService());
  getIt.registerSingleton<DadataService>(DadataService());

  getIt.registerLazySingleton(() => GetTaskByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentCompany(getIt()));
  getIt.registerLazySingleton(() => ChangeStatusUseCase(getIt()));
  getIt.registerLazySingleton(() => GetStartedReviewForTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => GetListReviewTemplatesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetArticlesByTypeUseCase(getIt()));
  getIt.registerLazySingleton(() => GetArticlesCountByCompanyUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => GetArticleTypeByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNotificationsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCompaniesUseCase(getIt()));
  getIt.registerLazySingleton(() => ChangeCompanyUseCase(getIt()));

  getIt.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl());

  getIt.registerSingleton<ConfigRepository>(ConfigRepository(getIt<ConfigService>()));
  getIt.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(getIt(), getIt()));

  getIt.registerSingleton<TaskRemoteDatasource>(TaskRemoteDatasourceImpl());
  getIt.registerSingleton<ReviewTemplateRemoteDataSource>(ReviewTemplateRemoteDataSourceImpl());
  getIt.registerSingleton<ReviewTemplateLocalDataSource>(ReviewTemplateLocalDataSourceImpl());
  getIt.registerSingleton<ReviewTemplateStepLocalDataSource>(ReviewTemplateStepLocalDataSourceImpl());
  getIt.registerSingleton<ReviewTemplateStepFormLocalDataSource>(ReviewTemplateStepFormLocalDataSourceImpl());
  getIt.registerSingleton<ReviewTemplateStepFormFieldLocalDataSource>(ReviewTemplateStepFormFieldLocalDataSourceImpl());
  getIt.registerLazySingleton<ReviewTemplateSectionLocalDataSource>(() => ReviewTemplateSectionLocalDataSourceImpl());
  getIt.registerSingleton<ReviewTemplateSectionRepository>(ReviewTemplateSectionRepositoryImpl(getIt()));

  getIt.registerSingleton<TaskRepository>(TaskRepositoryImpl(getIt<TaskRemoteDatasource>()));

  getIt.registerSingleton<ArticleTypeRepository>(ArticleTypeRepositoryImpl());
  getIt.registerSingleton<ReviewTemplateFormRepository>(ReviewTemplateFormRepositoryImpl());
  getIt.registerSingleton<ReviewTemplateStepRepository>(ReviewTemplateStepRepositoryImpl(getIt(), getIt()));
  getIt.registerSingleton<ReviewTemplateRepository>(ReviewTemplateRepositoryImpl(getIt(), getIt(), getIt(), getIt()));
  getIt.registerSingleton<ReviewTemplateFormFieldRepository>(ReviewTemplateFormFieldRepositoryImpl());

  getIt.registerSingleton<NotificationRepository>(NotificationRepositoryImpl(getIt<NotificationService>()));

  getIt.registerSingleton<CompanyRepository>(CompanyRepositoryImpl());

  getIt.registerSingleton<ReviewTemplateStepFormRepository>(ReviewTemplateStepFormRepositoryImpl(getIt()));
  getIt.registerSingleton<ReviewTemplateStepFormFieldRepository>(ReviewTemplateStepFormFieldRepositoryImpl(getIt()));
  getIt.registerSingleton<ReviewLocationRepository>(ReviewLocationRepositoryImpl());

  getIt.registerSingleton<ReviewStepFileRepository>(ReviewStepFileRepositoryImpl());
  getIt.registerSingleton<ReviewStepViolationRepository>(ReviewStepViolationRepositoryImpl());
  getIt.registerSingleton<UploadRepository>(UploadRepositoryImpl());
  getIt.registerSingleton<ReviewRepository>(ReviewRepositoryImpl(getIt(), getIt(), getIt(), getIt(), getIt()));

  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<SignService>(SignService());
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl(getIt<UserService>(), getIt<SignService>()));
  getIt.registerSingleton<SignUpRepository>(SignUpRepositoryImpl(getIt<SignService>()));

  getIt.registerLazySingleton(() => GetSectionsForReviewTemplate(getIt()));

  getIt.registerSingleton<FileExportService>(FileExportService());

  getIt.registerSingleton<PlatformService>(PlatformService(getIt<ConfigRepository>()));

  getIt.registerSingleton<RejectDelegateService>(RejectDelegateService());
  getIt.registerSingleton<RejectDelegateRepository>(RejectDelegateRepositoryImpl(getIt<RejectDelegateService>()));

  getIt.registerSingleton<ReviewService>(ReviewService(
    reviewRepository: getIt<ReviewRepository>(),
    reviewLocationRepository: getIt<ReviewLocationRepository>(),
    reviewStepFileRepository: getIt<ReviewStepFileRepository>(),
    reviewStepViolationRepository: getIt<ReviewStepViolationRepository>(),
    reviewTemplateRepository: getIt<ReviewTemplateRepository>(),
    reviewTemplateStepRepository: getIt<ReviewTemplateStepRepository>(),
    reviewTemplateStepFormRepository: getIt<ReviewTemplateStepFormRepository>(),
    reviewTemplateSectionRepository: getIt<ReviewTemplateSectionRepository>(),
    uploadRepository: getIt<UploadRepository>(),
  ));

  getIt.registerSingleton<PlatformInfo>(await (getIt<PlatformService>()).getInfo());

  getIt.registerSingleton<HelpQuestionRepository>(HelpQuestionRepositoryImpl());

  getIt.registerSingleton(ReviewsCountService());

  getIt.registerSingleton<FileHashService>(FileHashService());
  getIt.registerSingleton<DataService>(DataService());
  getIt.registerLazySingleton<LocationService>(() => LocationServiceImpl());
  getIt.registerLazySingleton(() => AddUsersStepsToReviewTemplate(getIt()));
  getIt.registerLazySingleton(() => GetFullStepsForReviewTemplate(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
  getIt.registerLazySingleton(() => CopySectionUseCase(getIt(), getIt()));
  getIt.registerLazySingleton(() => UpdateStepUseCase(getIt()));

  runApp(App());
}
