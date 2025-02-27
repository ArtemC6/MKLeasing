import 'dart:io';

import 'package:leasing_company/api/api.dart';

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return host == Uri.parse(Api.baseUrl).host && port == 443;
      };
  }
}
