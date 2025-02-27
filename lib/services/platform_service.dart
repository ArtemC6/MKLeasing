import 'dart:io';

import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/core/config/repositories/config_repository.dart';

class PlatformService {
  final ConfigRepository configRepository;

  PlatformService(this.configRepository);

  Future<PlatformInfo> getInfo() async {
    String platform = Platform.isAndroid ? 'android' : 'ios';
    return PlatformInfo(
      store: Store(
        name: Platform.isAndroid ? 'GooglePlay' : 'AppStore',
        appUrl: '${Api.baseUrl}/api/v1/versions/update?platform=$platform',
      ),
    );
  }
}

class Store {
  final String name;
  final String appUrl;

  Store({required this.name, required this.appUrl});
}

class PlatformInfo {
  final Store store;

  PlatformInfo({required this.store});
}
