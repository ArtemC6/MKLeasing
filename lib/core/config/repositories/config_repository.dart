import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:leasing_company/api/ConfigService.dart';
import 'package:leasing_company/core/config/models/config_model.dart';
import 'package:leasing_company/main.dart';

class ConfigRepository {
  final ConfigService configService;
  Config? config;
  Box? appBox;
  StreamController<Config>? controller;

  ConfigRepository(this.configService) {
    appBox = getIt.get(instanceName: 'AppBox');
    controller = StreamController<Config>.broadcast(
        onListen: () => controller?.sink.add(config!));
  }

  Future<Config> get({bool force = false}) async {
    if (config == null || force) {
      dynamic json;

      Response? response;
      Object? responseException;
      try {
        response = await configService.get();
      } catch (exception) {
        print('Handled exception - $exception');
        responseException = exception.toString();
      }
      if (response?.statusCode == 200) {
        appBox?.put('cache.config', response?.body);
        if (response?.body != null) {
          json = jsonDecode(response!.body);
          json['is_offline'] = false;
        }
      } else if (appBox?.containsKey('cache.config') == true) {
        String rawJson = appBox!.get('cache.config');
        json = jsonDecode(rawJson);
        json['access'] = true;
        json['is_offline'] = true;
      } else {
        throw new ServerIsNotAvailableAndHaveNotCacheOfConfig(
          responseException.toString(),
        );
      }

      config = Config.fromJson(json);
      controller?.add(config!);
    }
    return config!;
  }
}

class ServerIsNotAvailableAndHaveNotCacheOfConfig implements Exception {
  final String message;

  ServerIsNotAvailableAndHaveNotCacheOfConfig(this.message);
}
