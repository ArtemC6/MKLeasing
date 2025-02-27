import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_location_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_violation_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_section_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/features/uploads/domain/repositories/upload_repository.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';

enum EntityType { REVIEW, STEP_FILE, LOCATION }

enum EntityAction {
  REVIEW_STORE,
  REVIEW_INTERRUPT,
  REVIEW_FINISH,
  STEP_FILE_UPLOAD,
  LOCATION_UPLOAD,
  ATTACH_COMMENTS,
  ATTACH_VIOLATIONS,
  ATTACH_DELETING_FILES,
}

class ReviewService extends Api {
  ReviewRepository reviewRepository;
  ReviewTemplateRepository reviewTemplateRepository;
  ReviewTemplateStepRepository reviewTemplateStepRepository;
  ReviewTemplateStepFormRepository reviewTemplateStepFormRepository;
  ReviewTemplateSectionRepository reviewTemplateSectionRepository;
  ReviewStepViolationRepository reviewStepViolationRepository;
  ReviewStepFileRepository reviewStepFileRepository;
  ReviewLocationRepository reviewLocationRepository;
  UploadRepository uploadRepository;
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  ReviewService({
    required this.reviewRepository,
    required this.reviewTemplateRepository,
    required this.reviewTemplateStepRepository,
    required this.reviewTemplateStepFormRepository,
    required this.reviewTemplateSectionRepository,
    required this.reviewStepViolationRepository,
    required this.reviewStepFileRepository,
    required this.reviewLocationRepository,
    required this.uploadRepository,
  });

  Future<void> store(String reviewUuid) async {
    Review review = (await reviewRepository.getByUuid(reviewUuid))!;

    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    Map<String, String> task = {};
    if (review.remoteTaskId != null) {
      task['review[task_id]'] = review.remoteTaskId.toString();
    }

    DateTime onDeviceCreatedAt = DateTime.now();
    String taskId = await enqueue(
        this.url + "/v3/reviews", review.uuid, review.companyUuid,
        data: {
          'review[uuid]': review.uuid,
          'review[udid]': udid != null ? udid : '',
          'review[article_id]': review.remoteArticleId.toString(),
          'review[review_template_id]': review.remoteTemplateId.toString(),
          ...task,
          'review[started_at]':
              (review.startedAt.millisecondsSinceEpoch ~/ 1000).toString(),
          'review[device_started_at]':
              (review.onDeviceStartedAt.millisecondsSinceEpoch ~/ 1000)
                  .toString(),
          'review[is_offline]': review.offline == true ? '1' : '0',
        });

    await uploadRepository.create(
      reviewUuid: review.uuid,
      taskId: taskId,
      entityAction: EntityAction.REVIEW_STORE,
      entityType: EntityType.REVIEW,
      entityId: review.uuid,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
    );
  }

  Future<void> interrupt(String reviewUuid) async {
    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    // refresh data from DB
    Review review = (await reviewRepository.getByUuid(reviewUuid))!;

    Map<String, dynamic> structure = await makeReviewStructure(review);

    Map<String, String> task = {};
    if (review.remoteTaskId != null) {
      task['review[task_id]'] = review.remoteTaskId.toString();
    }

    DateTime onDeviceCreatedAt = DateTime.now();
    String taskId = await enqueue(
        this.url + "/v3/reviews/interrupt", review.uuid, review.companyUuid,
        data: {
          'review[uuid]': review.uuid,
          'review[interrupted_at]':
              (review.interruptedAt!.millisecondsSinceEpoch ~/ 1000).toString(),
          'review[device_interrupted_at]':
              (review.onDeviceInterruptedAt!.millisecondsSinceEpoch ~/ 1000)
                  .toString(),
          'review[structure]': jsonEncode(structure),

          //base review
          'review[udid]': udid != null ? udid : '',
          'review[article_id]': review.remoteArticleId.toString(),
          'review[review_template_id]': review.remoteTemplateId.toString(),
          ...task,
          'review[started_at]':
              (review.startedAt.millisecondsSinceEpoch ~/ 1000).toString(),
          'review[device_started_at]':
              (review.onDeviceStartedAt.millisecondsSinceEpoch ~/ 1000)
                  .toString(),
          'review[is_offline]': review.offline == true ? '1' : '0',
        });

    await uploadRepository.create(
      reviewUuid: review.uuid,
      taskId: taskId,
      entityAction: EntityAction.REVIEW_INTERRUPT,
      entityType: EntityType.REVIEW,
      entityId: review.uuid,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
    );
  }

  Future<void> finish(String reviewUuid) async {
    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    // refresh data from DB
    Review review = (await reviewRepository.getByUuid(reviewUuid))!;

    Map<String, dynamic> structure = await makeReviewStructure(review);
    Map<String, String> task = {};
    if (review.remoteTaskId != null) {
      task['review[task_id]'] = review.remoteTaskId.toString();
    }

    DateTime onDeviceCreatedAt = DateTime.now();
    String taskId = await enqueue(
        this.url + "/v3/reviews/finish", review.uuid, review.companyUuid,
        data: {
          'review[uuid]': review.uuid,
          'review[finished_at]':
              (review.finishedAt!.millisecondsSinceEpoch ~/ 1000).toString(),
          'review[device_finished_at]':
              (review.onDeviceFinishedAt!.millisecondsSinceEpoch ~/ 1000)
                  .toString(),
          'review[structure]': jsonEncode(structure),

          // base review
          'review[udid]': udid != null ? udid : '',
          'review[article_id]': review.remoteArticleId.toString(),
          'review[review_template_id]': review.remoteTemplateId.toString(),
          ...task,
          'review[started_at]':
              (review.startedAt.millisecondsSinceEpoch ~/ 1000).toString(),
          'review[device_started_at]':
              (review.onDeviceStartedAt.millisecondsSinceEpoch ~/ 1000)
                  .toString(),
          'review[is_offline]': review.offline == true ? '1' : '0',
        });

    await uploadRepository.create(
      reviewUuid: review.uuid,
      taskId: taskId,
      entityAction: EntityAction.REVIEW_FINISH,
      entityType: EntityType.REVIEW,
      entityId: review.uuid,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
    );
  }

  Future<Map<String, dynamic>> makeReviewStructure(Review review) async {
    List<ReviewTemplateStep> steps =
        await reviewTemplateStepRepository.getForTemplateAndReview(
            review.companyUuid, review.templateId, review.uuid);

    List<ReviewStepFile> files =
        await reviewStepFileRepository.getForReview(review.uuid);

    int locationsCount =
        await reviewLocationRepository.getForReviewCount(review.uuid);

    Map<String, dynamic> structure = {
      'steps': {},
      'locations_count': locationsCount
    };

    steps.forEach((step) {
      List<String> filesUuids = files
          .where((element) => element.stepId == step.id)
          .map((e) => e.uuid)
          .cast<String>()
          .toList();

      structure['steps'][step.remoteUuid] = {
        'files': filesUuids,
      };
    });

    return structure;
  }

  Future<void> attachMedia(ReviewStepFile stepFile) async {
    Review review = (await reviewRepository.getByUuid(stepFile.reviewUuid))!;

    ReviewTemplateStep step =
        (await reviewTemplateStepRepository.getById(stepFile.stepId))!;

    ReviewSection? section = step.localSectionId != null
        ? await reviewTemplateSectionRepository.getById(step.localSectionId!)
        : null;

    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    File fileItem;
    if (stepFile.path == null) {
      fileItem = await getFakeFileItem();
    } else {
      var realFilepath = join(await getStorageDir(), basename(stepFile.path!));
      var file = File(realFilepath);
      if (await file.exists()) {
        fileItem = File(
          realFilepath,
        );
      } else {
        // lost file
        fileItem = await getFakeFileItem();
      }
    }
    List<File> fileItems = [fileItem];

    Map<String, String> task = {};
    if (review.remoteTaskId != null) {
      task['review[task_id]'] = review.remoteTaskId.toString();
    }

    Map<String, String> data = {
      // media
      'media[uuid]': stepFile.uuid,
      'media[file_uuid]': stepFile.uuid,
      'media[type]': stepFile.type, // in future can be different of step.type
      'media[created_at]':
          (stepFile.createdAt.millisecondsSinceEpoch ~/ 1000).toString(),
      'media[device_created_at]':
          (stepFile.onDeviceCreatedAt.millisecondsSinceEpoch ~/ 1000)
              .toString(),
      'media[deleted_by_user_at]': stepFile.deletedByUserAt != null
          ? (stepFile.deletedByUserAt!.millisecondsSinceEpoch ~/ 1000)
              .toString()
          : "",
      'media[skipped]': stepFile.path == null ? '1' : '0',

      // step
      'step[uuid]': step.remoteUuid!,

      //review
      'review[uuid]': review.uuid,
      'review[udid]': udid != null ? udid : '',
      'review[article_id]': review.remoteArticleId.toString(),
      'review[review_template_id]': review.remoteTemplateId.toString(),
      ...task,

      'review[started_at]':
          (review.startedAt.millisecondsSinceEpoch ~/ 1000).toString(),
      'review[device_started_at]':
          (review.onDeviceStartedAt.millisecondsSinceEpoch ~/ 1000).toString(),
      'review[is_offline]': review.offline == true ? '1' : '0',
    };

    if (stepFile.hash != null) {
      data.addAll({
        'media[hash]': stepFile.hash!,
      });
    }

    // Если шаг был создан во время осмотра - добавить его в отчет
    if (step.remoteId == null) {
      data.addAll({
        'step[title]': step.title,
        'step[subtitle]': step.subtitle != null ? step.subtitle! : "",
        'step[type]': step.type,
        'step[weight]': step.weight.toString(),
      });
      // если шаг является формой
      if (step.formId != null) {
        var form = await reviewTemplateStepFormRepository.getByLocalId(
            step.companyUuid, step.formId!);
        if (form != null) {
          data.addAll({
            'step[form_id]': form.remoteId.toString(),
          });
        }
      }
      // если шаг находится в секции
      if (section != null) {
        data.addAll({
          'step[section][uuid]': section.uuid,
        });
      }
      // если секция создана пользователем
      if (section != null && section.remoteId == null) {
        data.addAll({
          'step[section][title]': section.title,
          'step[section][subtitle]':
              section.subtitle != null ? section.subtitle! : "",
          'step[section][weight]': step.weight.toString(),
        });
      }
    }

    DateTime onDeviceCreatedAt = DateTime.now();
    String taskId = await enqueue(this.url + '/v3/reviews/attach_media',
        stepFile.uuid, review.companyUuid,
        data: data, files: fileItems);

    await uploadRepository.create(
      reviewUuid: review.uuid,
      taskId: taskId,
      entityAction: EntityAction.STEP_FILE_UPLOAD,
      entityType: EntityType.STEP_FILE,
      entityId: stepFile.uuid,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
    );
  }

  Future<void> attachLocation(ReviewLocation location,
      [Review? reviewModel]) async {
    bool isRealDevice = await _isPhysicalDevice();
    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    Review review = reviewModel ??=
        (await reviewRepository.getByUuid(location.reviewUuid))!;

    Map<String, String> task = {};
    if (review.remoteTaskId != null) {
      task['review[task_id]'] = review.remoteTaskId.toString();
    }

    Map<String, String> data = {
      // location
      'location[uuid]': location.uuid,
      'location[latitude]': location.latitude.toString(),
      'location[longitude]': location.longitude.toString(),
      'location[accuracy]': location.accuracy.toString(),
      'location[created_at]':
          (location.createdAt.millisecondsSinceEpoch ~/ 1000).toString(),
      'location[device_created_at]':
          (location.onDeviceCreatedAt.millisecondsSinceEpoch ~/ 1000)
              .toString(),
      'location[gps_created_at]':
          (location.gpsCreatedAt.millisecondsSinceEpoch ~/ 1000).toString(),
      'location[is_real_device]': isRealDevice ? '1' : '0',
      'location[is_ios]': Platform.isIOS ? '1' : '0',
      'location[is_mocked]': location.mocked == true ? '1' : '0',

      // review
      'review[uuid]': review.uuid,
      'review[udid]': udid != null ? udid : '',
      'review[article_id]': review.remoteArticleId.toString(),
      'review[review_template_id]': review.remoteTemplateId.toString(),
      ...task,
      'review[started_at]':
          (review.startedAt.millisecondsSinceEpoch ~/ 1000).toString(),
      'review[device_started_at]':
          (review.onDeviceStartedAt.millisecondsSinceEpoch ~/ 1000).toString(),
      'review[is_offline]': review.offline == true ? '1' : '0',
    };

    DateTime onDeviceCreatedAt = DateTime.now();
    String taskId = await enqueue(this.url + "/v3/reviews/attach_location",
        location.uuid, review.companyUuid,
        data: data);

    await uploadRepository.create(
      reviewUuid: review.uuid,
      taskId: taskId,
      entityAction: EntityAction.LOCATION_UPLOAD,
      entityType: EntityType.LOCATION,
      entityId: location.uuid,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
    );
  }

  Future<String> enqueue(String url, String uuid, String companyUuid,
      {Map<String, String>? data, List<File>? files}) async {
    String accessToken = this.appBox.get('accessToken');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final dio = Dio();

    if (files != null) {
      final formData = FormData.fromMap({
        ...data!,
        'data': files
            .map((file) => MultipartFile.fromFileSync(file.path,
                filename: file.path.split('/').last))
            .toList(),
      });

      dio.options.headers = {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
        'Version': this.version,
        'Tenant-Id': companyUuid,
        'Device-Uuid': await FlutterUdid.udid,
        'Device-Model': Api.deviceModel,
        'Package': packageInfo.packageName,
      };

      try {
        final response = await dio.post(url, data: formData);
        print('Response: ${response.statusCode}');
        return response.data.toString();
      } catch (e) {
        rethrow;
      }
    } else {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll({
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Version': this.version,
          'Tenant-Id': companyUuid,
          'Device-Uuid': await FlutterUdid.udid,
          'Device-Model': Api.deviceModel,
          'Package': packageInfo.packageName,
        })
        ..fields.addAll(data!);

      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      return responseString;
    }
  }

  Future<File> getFakeFileItem() async {
    String path = join(await getStorageDir(), "fake.png");
    var file = File(path);
    if (!await file.exists()) {
      await file.writeAsString('fake');
    }
    return File(
      path,
    );
  }

  Future<void> attachComments(String reviewUuid) async {
    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    // refresh data from DB
    Review review = (await reviewRepository.getByUuid(reviewUuid))!;

    Map<String, String> task = {};
    if (review.remoteTaskId != null) {
      task['review[task_id]'] = review.remoteTaskId.toString();
    }

    Map<String, String> comments = {};
    var files = await reviewStepFileRepository.getForReview(reviewUuid);
    files
        .where((f) => f.comment != null && f.comment!.isNotEmpty)
        .forEach((f) => comments['media[${f.uuid}]'] = f.comment!);

    Map<String, String> reviewMeta = getReviewReasonsTimesMeta(review);

    DateTime onDeviceCreatedAt = DateTime.now();
    String taskId = await enqueue(this.url + "/v3/reviews/attach_comments",
        review.uuid, review.companyUuid,
        data: {
          'review[uuid]': review.uuid,

          // (finished_at + device_finished_at) || (interrupted_at + device_interrupted_at)
          ...reviewMeta,

          // base review
          'review[udid]': udid != null ? udid : '',
          'review[article_id]': review.remoteArticleId.toString(),
          'review[review_template_id]': review.remoteTemplateId.toString(),
          ...task,
          'review[started_at]':
              (review.startedAt.millisecondsSinceEpoch ~/ 1000).toString(),
          'review[device_started_at]':
              (review.onDeviceStartedAt.millisecondsSinceEpoch ~/ 1000)
                  .toString(),
          'review[is_offline]': review.offline == true ? '1' : '0',

          ...comments,
        });

    await uploadRepository.create(
      reviewUuid: review.uuid,
      taskId: taskId,
      entityAction: EntityAction.ATTACH_COMMENTS,
      entityType: EntityType.REVIEW,
      entityId: review.uuid,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
    );
  }

  Map<String, String> getReviewReasonsTimesMeta(Review review) {
    Map<String, String> reviewMeta = {};
    if (review.finishedAt != null) {
      reviewMeta['review[finished_at]'] =
          (review.finishedAt!.millisecondsSinceEpoch ~/ 1000).toString();
      reviewMeta['review[device_finished_at]'] =
          (review.onDeviceFinishedAt!.millisecondsSinceEpoch ~/ 1000)
              .toString();
    } else if (review.interruptedAt != null) {
      reviewMeta['review[interrupted_at]'] =
          (review.interruptedAt!.millisecondsSinceEpoch ~/ 1000).toString();
      reviewMeta['review[device_interrupted_at]'] =
          (review.onDeviceInterruptedAt!.millisecondsSinceEpoch ~/ 1000)
              .toString();
    }
    return reviewMeta;
  }

  Future<void> attachViolations(String reviewUuid) async {
    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    // refresh data from DB
    Review review = (await reviewRepository.getByUuid(reviewUuid))!;

    Map<String, String> task = {};
    if (review.remoteTaskId != null) {
      task['review[task_id]'] = review.remoteTaskId.toString();
    }

    var violations =
        await reviewStepViolationRepository.getForReview(reviewUuid);

    var steps = await reviewTemplateStepRepository.getForTemplateAndReview(
        review.companyUuid, review.templateId, review.uuid);

    Map<String, String> violationsMap = {};
    String query = '?';
    violations
        .map((v) => steps.firstWhere((s) => s.id == v.stepId).remoteUuid!)
        .forEach((stepRemoteUuid) => query += 'violations[]=$stepRemoteUuid&');

    Map<String, String> reviewMeta = getReviewReasonsTimesMeta(review);

    DateTime onDeviceCreatedAt = DateTime.now();
    String taskId = await enqueue(
        this.url + "/v3/reviews/attach_violations" + query,
        review.uuid,
        review.companyUuid,
        data: {
          'review[uuid]': review.uuid,

          // (finished_at + device_finished_at) || (interrupted_at + device_interrupted_at)
          ...reviewMeta,

          // base review
          'review[udid]': udid != null ? udid : '',
          'review[article_id]': review.remoteArticleId.toString(),
          'review[review_template_id]': review.remoteTemplateId.toString(),
          ...task,
          'review[started_at]':
              (review.startedAt.millisecondsSinceEpoch ~/ 1000).toString(),
          'review[device_started_at]':
              (review.onDeviceStartedAt.millisecondsSinceEpoch ~/ 1000)
                  .toString(),
          'review[is_offline]': review.offline == true ? '1' : '0',

          ...violationsMap,
        });

    await uploadRepository.create(
      reviewUuid: review.uuid,
      taskId: taskId,
      entityAction: EntityAction.ATTACH_VIOLATIONS,
      entityType: EntityType.REVIEW,
      entityId: review.uuid,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
    );
  }

  Future<void> attachDeleting(String reviewUuid) async {
    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    // refresh data from DB
    Review review = (await reviewRepository.getByUuid(reviewUuid))!;

    Map<String, String> task = {};
    if (review.remoteTaskId != null) {
      task['review[task_id]'] = review.remoteTaskId.toString();
    }

    Map<String, String> deleting = {};
    var files = await reviewStepFileRepository.getForReview(reviewUuid);
    files.where((f) => f.deletedByUserAt != null).forEach((f) =>
        deleting['deleted_media[${f.uuid}]'] =
            (f.deletedByUserAt!.millisecondsSinceEpoch ~/ 1000).toString());

    Map<String, String> reviewMeta = getReviewReasonsTimesMeta(review);

    DateTime onDeviceCreatedAt = DateTime.now();
    String taskId = await enqueue(this.url + "/v3/reviews/attach_deleting",
        review.uuid, review.companyUuid,
        data: {
          'review[uuid]': review.uuid,

          // (finished_at + device_finished_at) || (interrupted_at + device_interrupted_at)
          ...reviewMeta,

          // base review
          'review[udid]': udid != null ? udid : '',
          'review[article_id]': review.remoteArticleId.toString(),
          'review[review_template_id]': review.remoteTemplateId.toString(),
          ...task,
          'review[started_at]':
              (review.startedAt.millisecondsSinceEpoch ~/ 1000).toString(),
          'review[device_started_at]':
              (review.onDeviceStartedAt.millisecondsSinceEpoch ~/ 1000)
                  .toString(),
          'review[is_offline]': review.offline == true ? '1' : '0',

          ...deleting,
        });

    await uploadRepository.create(
      reviewUuid: review.uuid,
      taskId: taskId,
      entityAction: EntityAction.ATTACH_DELETING_FILES,
      entityType: EntityType.REVIEW,
      entityId: review.uuid,
      createdAt: onDeviceCreatedAt.toUtc(),
      onDeviceCreatedAt: onDeviceCreatedAt,
    );
  }

  Future<bool> _isPhysicalDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    bool isPhysicalDevice = false;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        isPhysicalDevice = androidInfo.isPhysicalDevice;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        isPhysicalDevice = iosInfo.isPhysicalDevice;
      }
    } catch (e) {
      print("Error checking if emulator: $e");
    }
    return isPhysicalDevice;
  }
}
