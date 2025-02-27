import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:path/path.dart';

class CameraFileManager {
  CameraFileManager();

  String _storageDir = '';
  String _compressedStorageDir = '';
  String cacheStorageDir = '';

  Future<void> initialize() async {
    _storageDir = await getStorageDir();
    _compressedStorageDir = await getCompressedStorageDir();
    cacheStorageDir = await getCacheStorageDir();
  }

  Future<Map<String, String>> savePhoto(XFile file) async {
    final starting = (DateTime.now().millisecondsSinceEpoch).round();
    final path = join(_storageDir, "$starting.png");
    final compressedPath = join(_compressedStorageDir, "$starting.png");
    final port = ReceivePort();
    final isolate = await Isolate.spawn(
        _savePhotoInIsolate,
        IsolateParamsModel(
          path,
          compressedPath,
          file.path,
          port.sendPort,
        ));
    await port.first;
    port.close();
    isolate.kill();
    return {"path": path, "compressedPath": compressedPath};
  }

  Future<Map<String, String>> saveVideo(XFile file, int startedAt) async {
    final path = join(_storageDir, "$startedAt.mp4");
    final compressedPath = join(_compressedStorageDir, "$startedAt.png");
    final port = ReceivePort();
    final isolate = await Isolate.spawn(
        _saveVideoInIsolate,
        IsolateParamsModel(
          path,
          compressedPath,
          file.path,
          port.sendPort,
        ));
    await port.first;
    port.close();
    isolate.kill();
    return {"path": path, "compressedPath": compressedPath};
  }

  Future<void> deleteFile({
    String? filePath,
    String? compressedPath,
    String? cacheFilePath,
  }) async {
    try {
      if (filePath != null) {
        await File(filePath).delete();
      }
      if (compressedPath != null) {
        await File(compressedPath).delete();
      }
      if (cacheFilePath != null) {
        await File(cacheFilePath).delete();
      }
    } catch (e) {
      print('The file has been deleted before');
    }
  }
}

class IsolateParamsModel {
  final String path;
  final String compressedPath;
  final filePath;
  final SendPort sendPort;

  IsolateParamsModel(
      this.path, this.compressedPath, this.filePath, this.sendPort);
}

Future<void> _savePhotoInIsolate(IsolateParamsModel params) async {
  final file = XFile(params.filePath);
  await file.saveTo(params.path);

  final img.Image? image = img.decodeImage(await file.readAsBytes());
  File(params.compressedPath)
      .writeAsBytesSync(img.encodeJpg(image!, quality: 50));

  params.sendPort.send('');
}

Future<void> _saveVideoInIsolate(IsolateParamsModel params) async {
  final file = XFile(params.filePath);
  await file.saveTo(params.path);

  params.sendPort.send('');
}
