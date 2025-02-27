import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:leasing_company/api/ReviewService.dart';
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/core/config/models/config_model.dart';
import 'package:leasing_company/core/config/repositories/config_repository.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_type_repository.dart';
import 'package:leasing_company/features/articles/presentation/choose_creating_article_type/bloc/choose_creating_article_type_bloc.dart';
import 'package:leasing_company/features/articles/presentation/choose_creating_article_type/page/choose_creating_article_type_page.dart';
import 'package:leasing_company/features/authentication/domain/repositories/user_repository.dart';
import 'package:leasing_company/features/authentication/presentation/login/bloc/login_bloc.dart';
import 'package:leasing_company/features/authentication/presentation/login/page/login_page.dart';
import 'package:leasing_company/features/authentication/presentation/recovery/bloc/recovery_bloc.dart';
import 'package:leasing_company/features/authentication/presentation/recovery/page/recovery_page.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/features/help/domain/repositories/help_question_repository.dart';
import 'package:leasing_company/features/help/presentation/help_questions/bloc/help_questions_bloc.dart';
import 'package:leasing_company/features/help/presentation/help_questions/page/help_questions_page.dart';
import 'package:leasing_company/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:leasing_company/features/home/presentation/page/home_page.dart';
import 'package:leasing_company/features/initial_loading/presentation/loading/bloc/loading_bloc.dart';
import 'package:leasing_company/features/initial_loading/presentation/loading/page/loading_page.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_location_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/bloc/review_list_bloc.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/page/review_list_page.dart';
import 'package:leasing_company/features/uploads/domain/repositories/upload_repository.dart';
import 'package:leasing_company/features/uploads/presentstion/uploads/bloc/uploads_bloc.dart';
import 'package:leasing_company/features/uploads/presentstion/uploads/page/uploads_page.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/push_messaging_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:throttling/throttling.dart';
// import 'package:wakelock/wakelock.dart';

class App extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  Timer? timer;
  late ConfigRepository configRepository;
  StreamSubscription? connectivitySubscription;
  Throttling? throttling;
  bool isHaveInternetConnection = true;

  AppState() {
    WidgetsBinding.instance.addObserver(this);
    configRepository = getIt.get<ConfigRepository>();
    start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      start();
    } else if (state == AppLifecycleState.paused) {
      stop();
    }
  }

  Future<Config?> getConfig({bool force = false}) async {
    try {
      return await configRepository.get(force: force);
    } catch (exception) {
      return null;
    }
  }

  start() {
    // Wakelock.enable();
    if (throttling == null || throttling?.isReady == false) {
      throttling = Throttling(duration: Duration(seconds: 5));
    }
    if (timer == null || timer?.isActive == false) {
      throttling?.throttle(() async => getConfig(force: true));
      timer = Timer.periodic(Duration(seconds: 30), (timer) async => throttling?.throttle(() async => getConfig(force: true)));
    }
    if (connectivitySubscription == null || connectivitySubscription?.isPaused == true) {
      connectivitySubscription = Connectivity().onConnectivityChanged.listen(
            (List<ConnectivityResult> result) => throttling?.throttle(
              () async {
                Config? config = await getConfig(force: true);
                if (config == null || config.isOffline == true) {
                  isHaveInternetConnection = false;
                  await Future.delayed(Duration(seconds: 5));
                  await getConfig(force: true);
                } else {
                  if (!isHaveInternetConnection) {
                    startUpload();
                    isHaveInternetConnection = true;
                  }
                }
              },
            ),
          );


    }
  }

  stop() {
    // Wakelock.disable();
    timer?.cancel();
    timer = null;
    connectivitySubscription?.cancel().then((x) => connectivitySubscription = null);
    throttling?.close().then((x) => throttling = null);
  }

  @override
  void initState() {
    super.initState();
    getIt.registerSingleton(
      PushMessagingService(
        fcm: getIt<FirebaseMessaging>(),
        localNotificationDetails: getIt<NotificationDetails>(),
        localNotificationsPlugin: getIt<FlutterLocalNotificationsPlugin>(),
        backgroundHandler: notificationBackgroundHandler,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: Api.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: App.navigatorKey,
      theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: Color(0xFFFDFDFD),
          appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFDFDFD),
          elevation: 1.5,
          shadowColor: Colors.black26,
          foregroundColor: Colors.black,
        ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Color(0xff246BFD),
          ),
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.white,
            modalBackgroundColor: Colors.white,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xff246BFD),
            textTheme: ButtonTextTheme.primary,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            dividerColor: Colors.white,
            unselectedLabelColor: Colors.white,
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
          dialogTheme: DialogTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider<LoadingBloc>(
              create: (context) => LoadingBloc(getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
              child: LoadingPage(),
            ),
        '/login': (context) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(userRepository: getIt<UserRepository>(), configRepository: getIt<ConfigRepository>()), child: LoginPage()),
        '/home': (context) => BlocProvider<HomePageBloc>(create: (context) => HomePageBloc(0), child: HomePage()),
        '/reviews': (context) => BlocProvider<ReviewListBloc>(create: (context) => ReviewListBloc(), child: ReviewListPage()),
        '/sign/reset': (context) => BlocProvider<RecoveryBloc>(
              create: (context) => RecoveryBloc(
                userRepository: getIt<UserRepository>(),
              ),
              child: RecoveryPage(),
            ),
        '/articleTypes/choose': (BuildContext context) => BlocProvider<ChooseCreatingArticleTypeBloc>(
              create: (context) => ChooseCreatingArticleTypeBloc(
                articleTypeRepository: getIt<ArticleTypeRepository>(),
                companyRepository: getIt<CompanyRepository>(),
              ),
              child: ChooseCreatingArticleTypePage(),
            ),
        '/help/questions': (BuildContext context) => BlocProvider<HelpQuestionsBloc>(
              create: (context) => HelpQuestionsBloc(helpQuestionRepository: getIt<HelpQuestionRepository>(), companyRepository: getIt<CompanyRepository>()),
              child: HelpQuestionsPage(),
            ),
        '/uploads': (BuildContext context) => BlocProvider<UploadsBloc>(
              create: (context) => UploadsBloc(getIt(), getIt(), getIt(), getIt()),
              child: UploadsPage(),
            ),
      },
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }

  Future startUpload() async {
    final _uploadRepository = getIt<UploadRepository>();
    final _reviewRepository = getIt<ReviewRepository>();
    final _reviewService = getIt<ReviewService>();
    final _reviewStepFileRepository = getIt<ReviewStepFileRepository>();
    final _reviewLocationRepository = getIt<ReviewLocationRepository>();

    try {
      await _uploadRepository.deleteAll();
      final reviewsForStore = await _reviewRepository.getStartedNotUploaded();
      await Future.wait(reviewsForStore.map((e) => _reviewService.store(e.uuid)));

      final reviewsForInterrupt = await _reviewRepository.getInterruptedNotUploaded();

      await Future.wait(reviewsForInterrupt.map((e) => _reviewService.interrupt(e.uuid)));

      final reviewsForFinished = await _reviewRepository.getNotFinishedUploaded();
      await Future.wait(reviewsForFinished.map((e) => _reviewService.finish(e.uuid)));

      final reviewsForAttachingComments = await _reviewRepository.getNotAttachedComments();
      await Future.wait(reviewsForAttachingComments.map((e) => _reviewService.attachComments(e.uuid)));

      final reviewsForAttachingViolations = await _reviewRepository.getNotAttachedViolations();
      await Future.wait(reviewsForAttachingViolations.map((e) => _reviewService.attachViolations(e.uuid)));

      final reviewsForAttachingDeletingMedia = await _reviewRepository.getNotAttachedDeletingMedia();
      await Future.wait(reviewsForAttachingDeletingMedia.map((e) => _reviewService.attachDeleting(e.uuid)));

      final filesNotUploaded = await _reviewStepFileRepository.getNotUploaded();
      await Future.wait(filesNotUploaded.map((e) => _reviewService.attachMedia(e)));

      final locationsNotUploaded = await _reviewLocationRepository.getNotUploaded();
      await Future.wait(locationsNotUploaded.map((e) => _reviewService.attachLocation(e)));

      final notFinishedUploads = await _uploadRepository.getNotUploaded();

      for (var upload in notFinishedUploads) {
        try {
          if (upload.entityAction == EntityAction.REVIEW_STORE.toString()) {
            final review = (await _reviewRepository.getByUuid(upload.reviewUuid))!;
            await _reviewService.store(review.uuid);
          } else if (upload.entityAction == EntityAction.REVIEW_INTERRUPT.toString()) {
            final review = (await _reviewRepository.getByUuid(upload.reviewUuid))!;
            await _reviewService.interrupt(review.uuid);
          } else if (upload.entityAction == EntityAction.REVIEW_FINISH.toString()) {
            final review = (await _reviewRepository.getByUuid(upload.reviewUuid))!;
            await _reviewService.finish(review.uuid);
          } else if (upload.entityAction == EntityAction.STEP_FILE_UPLOAD.toString()) {
            final stepFile = (await _reviewStepFileRepository.getByUuid(upload.entityId))!;
            await _reviewService.attachMedia(stepFile);
          } else if (upload.entityAction == EntityAction.LOCATION_UPLOAD.toString()) {
            final location = (await _reviewLocationRepository.getByUuid(upload.entityId))!;
            await _reviewService.attachLocation(location);
          } else if (upload.entityAction == EntityAction.ATTACH_COMMENTS.toString()) {
            await _reviewService.attachComments(upload.entityId);
          } else if (upload.entityAction == EntityAction.ATTACH_VIOLATIONS.toString()) {
            await _reviewService.attachViolations(upload.entityId);
          } else if (upload.entityAction == EntityAction.ATTACH_DELETING_FILES.toString()) {
            await _reviewService.attachDeleting(upload.entityId);
          } else {
            throw Exception('Undefined entityAction');
          }
          await _uploadRepository.delete(upload.taskId);

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
    } catch (e) {
      print(e);
    }
  }
}
