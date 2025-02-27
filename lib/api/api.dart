import 'package:extended_image/extended_image.dart';
import 'package:hive/hive.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../main.dart';

class Api {
  static String appName = 'MKLeasing';

  static String notificationsChannelId = 'notification_channel';
  static String notificationsChannelName = 'Notifications';
  static String notificationsChannelDescription = 'Push notifications';

  static String baseUrl = 'https://mkleasing.check-up-online.ru';
  // static String baseUrl = 'https://dev-3.staging-mc.check-up-online.ru';

  String url = "${Api.baseUrl}/api";
  static String userAgreementUrl = "${Api.baseUrl}/user-agreement.pdf";
  static String privacyUrl = "${Api.baseUrl}/privacy.pdf";

  static String iOSAppStoreCountry = 'ru';

  static String dadataApiKey = '3927f94c08a212bac0189844cabbb420c2e9db9e';

  String version = getIt<PackageInfo>().buildNumber;

  static Client client = InterceptedClient.build(interceptors: [
    // CommonInterceptor(),
  ]);

  late Box appBox;
  // late FlutterUploader uploader;
  static late String deviceModel;

  Api() {
    appBox = getIt.get(instanceName: 'AppBox');
    // uploader = getIt.get<FlutterUploader>();
  }
}
