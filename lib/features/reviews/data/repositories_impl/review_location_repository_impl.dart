import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_location_repository.dart';
import 'package:leasing_company/main.dart';

class ReviewLocationRepositoryImpl implements ReviewLocationRepository {
  Future<List<ReviewLocation>> getForReview(String reviewUuid) async {
    return (database.select(database.reviewLocations)
          ..where((tbl) => tbl.reviewUuid.equals(reviewUuid)))
        .get();
  }

  Future<int> getForReviewCount(String reviewUuid) async {
    var countQuery = countAll(
        filter: database.reviewLocations.reviewUuid.equals(reviewUuid));

    TypedResult result = await (database.selectOnly(database.reviewLocations)
          ..addColumns([countQuery]))
        .getSingle();

    return result.rawData.data['c0'] as int;
  }

  @override
  Future<ReviewLocation> create(
      {required String uuid,
      required String reviewUuid,
      required double latitude,
      required double longitude,
      required double accuracy,
      required DateTime createdAt,
      required DateTime onDeviceCreatedAt,
      required DateTime gpsCreatedAt,
      required bool? mocked}) async {
    await database
        .into(database.reviewLocations)
        .insert(ReviewLocationsCompanion.insert(
          uuid: uuid,
          latitude: latitude,
          longitude: longitude,
          accuracy: accuracy,
          createdAt: createdAt,
          onDeviceCreatedAt: onDeviceCreatedAt,
          gpsCreatedAt: gpsCreatedAt,
          reviewUuid: reviewUuid,
          mocked: Value(mocked),
        ));

    return (database.select(database.reviewLocations)
          ..where((tbl) =>
              tbl.reviewUuid.equals(reviewUuid) & tbl.uuid.equals(uuid)))
        .getSingle();
  }

  Future<ReviewLocation?> getByUuid(String uuid) async {
    return (database.select(database.reviewLocations)
          ..where((tbl) => tbl.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  Future update(String uuid, {DateTime? uploadedAt}) async {
    try {
      return await (database.update(database.reviewLocations)
            ..where((tbl) => tbl.uuid.equals(uuid)))
          .write(ReviewLocationsCompanion(
        uploadedAt: uploadedAt != null ? Value(uploadedAt) : Value.absent(),
      ));
    } catch (e) {
      print(e);
    }
  }

  Future<bool> hasNotUploadedForReview(String uuid) async {
    final notUploadedLocations = await (database
            .select(database.reviewLocations)
          ..where(
              (tbl) => tbl.reviewUuid.equals(uuid) & tbl.uploadedAt.isNull()))
        .get();
    return notUploadedLocations.isNotEmpty;
  }

  Future deleteForReviewUuid(String uuid) {
    return (database.delete(database.reviewLocations)
          ..where((tbl) => tbl.reviewUuid.equals(uuid)))
        .go();
  }

  Future<List<ReviewLocation>> getNotUploaded() {
    return (database.select(database.reviewLocations)
          ..where((tbl) => tbl.uploadedAt.isNull()))
        .get();
  }
}
