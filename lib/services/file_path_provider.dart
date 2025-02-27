import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getStorageDir() async {
  return join((await getApplicationSupportDirectory()).path, 'storage');
}

Future<String> getCompressedStorageDir() async {
  return join(
      (await getApplicationSupportDirectory()).path, 'compressed-storage');
}

Future<String> getCacheStorageDir() async {
  return join((await getApplicationSupportDirectory()).path, 'cache');
}
