import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewStepFileRepository {
  Future<List<ReviewStepFile>> getForReview(String reviewUuid);

  Future<ReviewStepFile?> getById(int id);

  Future<ReviewStepFile?> getByUuid(String uuid);

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
  });

  Future<ReviewStepFile> createByEntity(ReviewStepFile stepFile);

  Future update(String uuid, {String? comment, DateTime? uploadedAt});

  hasNotUploadedForReview(String uuid);

  Future deleteForReviewUuid(String uuid);

  Future deleteByUuid(String uuid);

  Future delete(int id);

  Future<List<ReviewStepFile>> getNotUploaded();

  Future<List<ReviewStepFile>> get();
}
