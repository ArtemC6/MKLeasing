import 'package:leasing_company/api/ReviewService.dart';
import 'package:leasing_company/core/drift/drift.dart';

abstract class UploadRepository {
  Future<void> create({
    required String taskId,
    required String reviewUuid,
    required EntityAction entityAction,
    required EntityType entityType,
    required String entityId,
    required DateTime createdAt,
    required DateTime onDeviceCreatedAt,
  });

  Future<void> update(String taskId,
      {int? progress, int? status, DateTime? uploadedAt});

  Future<Upload?> getForStepFile(String stepFileUuid);

  Future<List<Upload>> getForStepFiles(List<String> stepFileUuids);

  Future<List<Upload>> getByTaskIds(List<String> taskIds);

  Future<Upload?> getByTaskId(String taskId);

  Future deleteByReviewUuid(String reviewUuid);

  Future deleteAll();

  Future<List<Upload>> getNotUploaded();

  Future delete(String taskId);

  Future<List<Upload>> get();
}
