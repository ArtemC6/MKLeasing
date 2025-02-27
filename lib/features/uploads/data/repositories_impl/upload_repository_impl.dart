import 'package:drift/drift.dart';
import 'package:leasing_company/api/ReviewService.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/uploads/domain/repositories/upload_repository.dart';
import 'package:leasing_company/main.dart';

class UploadRepositoryImpl implements UploadRepository {
  Future<void> create({
    required String taskId,
    required String reviewUuid,
    required EntityAction entityAction,
    required EntityType entityType,
    required String entityId,
    required DateTime createdAt,
    required DateTime onDeviceCreatedAt,
  }) async {
      await database.into(database.uploads).insert(UploadsCompanion.insert(
            reviewUuid: reviewUuid,
            taskId: taskId,
            entityAction: entityAction.toString(),
            entityType: entityType.toString(),
            entityId: entityId,
            progress: 0,
            status: 0,
            createdAt: onDeviceCreatedAt.toUtc(),
            onDeviceCreatedAt: onDeviceCreatedAt,
          ));
  }

  Future<void> update(String taskId,
      {int? progress, int? status, DateTime? uploadedAt}) async {
      await (database.update(database.uploads)
            ..where((tbl) => tbl.taskId.equals(taskId)))
          .write(UploadsCompanion(
        progress: progress != null ? Value(progress) : Value.absent(),
        status: status != null ? Value(status) : Value.absent(),
        uploadedAt: uploadedAt != null ? Value(uploadedAt) : Value.absent(),
      ));
  }

  Future<Upload?> getForStepFile(String stepFileUuid) async {
    return await (database.select(database.uploads)
          ..where((tbl) =>
              tbl.entityType.equals(EntityType.STEP_FILE.toString()) &
              tbl.entityId.equals(stepFileUuid)))
        .getSingleOrNull();
  }

  Future<List<Upload>> getForStepFiles(List<String> stepFileUuids) async {
    return await (database.select(database.uploads)
          ..where((tbl) =>
              tbl.entityType.equals(EntityType.STEP_FILE.toString()) &
              tbl.entityId.isIn(stepFileUuids)))
        .get();
  }

  Future<List<Upload>> getByTaskIds(List<String> taskIds) async {
    return await (database.select(database.uploads)
          ..where((tbl) => tbl.taskId.isIn(taskIds)))
        .get();
  }

  Future<Upload?> getByTaskId(String taskId) async {
    return await (database.select(database.uploads)
          ..where((tbl) => tbl.taskId.equals(taskId)))
        .getSingleOrNull();
  }

  Future deleteByReviewUuid(String reviewUuid) async {
    return await (database.delete(database.uploads)
          ..where((tbl) => tbl.reviewUuid.equals(reviewUuid)))
        .go();
  }

  Future deleteAll() {
    return database.delete(database.uploads).go();
  }

  Future<List<Upload>> getNotUploaded() async {
    return await (database.select(database.uploads)
          ..where((tbl) => tbl.uploadedAt.isNull()))
        .get();
  }

  Future delete(String taskId) async {
    return await (database.delete(database.uploads)
          ..where((tbl) => tbl.taskId.equals(taskId)))
        .go();
  }

  Future<List<Upload>> get() async {
    return await database.select(database.uploads).get();
  }
}
