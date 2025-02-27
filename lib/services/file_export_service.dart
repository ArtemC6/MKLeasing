import 'dart:io';

// import 'package:flutter_archive/flutter_archive.dart';
import 'package:archive/archive.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:path/path.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';

class FileExportService {

  get fromDir async => await getStorageDir();

  get toDir async => await getStorageDir();

  Future<List<FileSystemEntity>> getFilesFromStorage() async {
    String storageDir = await getStorageDir();
    Stream<FileSystemEntity> list = Directory(storageDir).list();

    // only "timestamp.png/mp4" files
    RegExp regExp = RegExp(r"(\d{10,}.(jpg|jpeg|png|mp4|qt|json))");

    return list
        .where((fileItem) => regExp.hasMatch(basename(fileItem.path)))
        .toList();
  }

  Future<bool> hasFilesForExport() async {
    List<FileSystemEntity> files = await this.getFilesFromStorage();
    return files.length > 0;
  }

  //todo add localization for strings and move descriptions to HelpPage
  Stream<ExportProgress> exportToZip() async* {
    yield ExportProgress(progress: 10, description: 'Сборка начата');

    List<FileSystemEntity> entityFiles = await getFilesFromStorage();

    if (entityFiles.isNotEmpty) {
      String zipFileName = join(await toDir, 'export.zip');
      final zipFile = File(zipFileName);

      if (await zipFile.exists()) {
        await zipFile.delete();
      }

      List<File> files = [];
      for (int i = 0; i < entityFiles.length; i++) {
        try {
          Future.delayed(Duration(seconds: 1));
          String baseFilename = basename(entityFiles[i].path);
          files.add(File(join(await fromDir, baseFilename)));
          yield ExportProgress(
            progress: 10 + ((40 / entityFiles.length) * i).round(),
            description: 'Импорт ${basename(entityFiles[i].path)}',
          );
        } catch (exception, stackTrace) {
          await Sentry.captureException(
            exception,
            stackTrace: stackTrace,
          );
        }
      }

      yield ExportProgress(progress: 75, description: 'Архивация начата');

      // Create a ZIP archive
      final archive = Archive();
      for (final file in files) {
        final fileBytes = await file.readAsBytes();
        archive.addFile(ArchiveFile(basename(file.path), fileBytes.length, fileBytes));
      }

      // Encode the archive to a zip file
      final zipEncoder = ZipEncoder();
      final zipBytes = zipEncoder.encode(archive);

      if (zipBytes != null) {
        await zipFile.writeAsBytes(zipBytes);
      }

      yield ExportProgress(progress: 90, description: 'Архивация завершена');
      await Future.delayed(Duration(seconds: 1));
      await Share.shareXFiles([XFile(zipFileName)]);
      // Uncomment if you want to delete the zip after sharing
      // await zipFile.delete();

      yield ExportProgress(progress: 100, description: 'Завершено');
    } else {
      await Future.delayed(Duration(seconds: 1));
      yield ExportProgress(progress: 0, description: 'Нет файлов для импорта');
    }
  }
}

class ExportProgress {
  final int progress;
  final String description;

  ExportProgress({required this.progress, required this.description});
}
