import 'dart:io';

import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class ReviewStepFileRepositoryImpl implements ReviewStepFileRepository {
  Future<List<ReviewStepFile>> getForReview(String reviewUuid) async {
    return (database.select(database.reviewStepFiles)
          ..where((tbl) => tbl.reviewUuid.equals(reviewUuid)))
        .get();
  }

  Future<ReviewStepFile?> getById(int id) {
    return (database.select(database.reviewStepFiles)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<ReviewStepFile?> getByUuid(String uuid) {
    return (database.select(database.reviewStepFiles)
          ..where((tbl) => tbl.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  Future<ReviewStepFile> create({
    required String companyUuid,
    required String reviewUuid,
    required int stepId,
    required String type,
    required DateTime createdAt,
    required DateTime onDeviceCreatedAt,
    String? path,
    String? compressedPath,
    String? hash,
    String? comment,
  }) async {
    int id = await database
        .into(database.reviewStepFiles)
        .insert(ReviewStepFilesCompanion.insert(
          uuid: Uuid().v4(),
          reviewUuid: reviewUuid,
          stepId: stepId,
          type: type,
          path: Value(path),
          compressedPath: Value(compressedPath),
          hash: Value(hash),
          comment: Value(comment),
          createdAt: createdAt,
          onDeviceCreatedAt: onDeviceCreatedAt,
        ));

    return (await getById(id))!;
  }

  Future<ReviewStepFile> createByEntity(ReviewStepFile stepFile) async {
    int id = await database.into(database.reviewStepFiles).insert(stepFile);

    return (await getById(id))!;
  }

  Future update(String uuid, {String? comment, DateTime? uploadedAt}) async {
      return (database.update(database.reviewStepFiles)
            ..where((tbl) => tbl.uuid.equals(uuid)))
          .write(ReviewStepFilesCompanion(
        comment: comment != null ? Value(comment) : Value.absent(),
        uploadedAt: uploadedAt != null ? Value(uploadedAt) : Value.absent(),
      ));
  }

  hasNotUploadedForReview(String uuid) async {
    var f = await (database.select(database.reviewStepFiles)
          ..where(
              (tbl) => tbl.reviewUuid.equals(uuid) & tbl.uploadedAt.isNull())
          ..limit(1))
        .getSingleOrNull();
    return f != null;
  }

  Future deleteForReviewUuid(String uuid) async {
    var files = await (database.select(database.reviewStepFiles)
          ..where((tbl) => tbl.reviewUuid.equals(uuid)))
        .get();

    final String compressedStorageDir = await getCompressedStorageDir();
    final String storageDir = await getStorageDir();

    var futures = files.map((e) async {
      if (e.path != null) {
        var f = File(join(storageDir, e.path));
        if (await f.exists()) {
          try {
            await f.delete();
          } catch (e) {}
        }
      }
      if (e.compressedPath != null) {
        var f = File(join(compressedStorageDir, e.compressedPath));
        if (await f.exists()) {
          try {
            await f.delete();
          } catch (e) {}
        }
      }
      await delete(e.id);
    });

    await Future.wait(futures);
  }

  Future deleteByUuid(String uuid) async {
      await (database.update(database.reviewStepFiles)
            ..where((tbl) => tbl.uuid.equals(uuid)))
          .write(ReviewStepFilesCompanion(
        deletedByUserAt: Value(DateTime.now()),
      ));
  }

  Future delete(int id) {
    return (database.delete(database.reviewStepFiles)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<List<ReviewStepFile>> getNotUploaded() {
    return (database.select(database.reviewStepFiles)
          ..where((tbl) => tbl.uploadedAt.isNull()))
        .get();
  }

  Future<List<ReviewStepFile>> get() {
    return database.select(database.reviewStepFiles).get();
  }
}
