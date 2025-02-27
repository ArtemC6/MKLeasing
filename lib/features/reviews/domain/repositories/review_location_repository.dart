import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewLocationRepository {
  Future<List<ReviewLocation>> getForReview(String reviewUuid);

  Future<int> getForReviewCount(String reviewUuid);

  Future<ReviewLocation> create({
    required String uuid,
    required String reviewUuid,
    required double latitude,
    required double longitude,
    required double accuracy,
    required DateTime createdAt,
    required DateTime onDeviceCreatedAt,
    required DateTime gpsCreatedAt,
    required bool? mocked,
  });

  Future<ReviewLocation?> getByUuid(String uuid);

  Future update(String uuid, {DateTime? uploadedAt});

  Future<bool> hasNotUploadedForReview(String uuid);

  Future deleteForReviewUuid(String uuid);

  Future<List<ReviewLocation>> getNotUploaded();
}
