import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/features/reviews/data/data_sources/data_sources_impl/review_template_step_local_data_source_impl.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_form_repository_impl.dart';
import 'package:leasing_company/features/reviews/data/repositories_impl/review_template_step_repository_impl.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:path/path.dart';

late ReviewTemplateStepRepositoryImpl _reviewTemplateStepRepository;

// @pragma('vm:entry-point')
void downloadReviewTemplatesFiles(args) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  _reviewTemplateStepRepository = ReviewTemplateStepRepositoryImpl(
    ReviewTemplateFormRepositoryImpl(),
    ReviewTemplateStepLocalDataSourceImpl(),
  );

  var steps = await _reviewTemplateStepRepository.getStepsForDownload();

  var futures = steps.map((step) async {
    if (step.contentImage != null) {
      try {
        await Future(() async => await downloadContentImage(step))
            .timeout(Duration(seconds: 20), onTimeout: null);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
      }
    }
    if (step.contentMask != null) {
      try {
        await Future(() async => await downloadContentMask(step))
            .timeout(Duration(seconds: 20), onTimeout: null);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
      }
    }
  }).toList();

  await Future.wait(futures);
}

downloadContentImage(ReviewTemplateStep step) async {
  String path = await downloadFile(step.contentImage!);
  return _reviewTemplateStepRepository.updateContentImage(
      step.companyUuid, step.id, path);
}

downloadContentMask(ReviewTemplateStep step) async {
  String path = await downloadFile(step.contentMask!);
  return _reviewTemplateStepRepository.updateContentMask(
      step.companyUuid, step.id, path);
}

Future<String> downloadFile(String url) async {
  try {
    final String cacheStorageDir = await getCacheStorageDir();
    String filename = basename(url);
    String filepath = join(cacheStorageDir, filename);
    Uri uri = Uri.parse(url);
    if (!await File(filepath).exists()) {
      Response responseFile =
          await Api.client.get(uri).timeout(Duration(seconds: 15));
      await File(filepath).writeAsBytes(responseFile.bodyBytes);
    }
    return filepath;
  } catch (e, stackTrace) {
    print('downloadFile future not completed: timeout');
    rethrow;
  }
}
