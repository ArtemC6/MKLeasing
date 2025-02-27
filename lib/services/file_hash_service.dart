import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class FileHashService {
  Future md5Hash(String path) async {
    try {
      File file = File(path);

      if (!file.existsSync()) {
        return '';
      }

      var hash = await md5.bind(file.openRead()).first;

      return hash.toString();
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return '';
    }
  }
}
