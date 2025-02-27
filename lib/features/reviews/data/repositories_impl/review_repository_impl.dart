import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_location_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_violation_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/uploads/domain/repositories/upload_repository.dart';
import 'package:leasing_company/main.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewLocationRepository _reviewLocationRepository;
  final ReviewStepFileRepository _reviewStepFileRepository;
  final UploadRepository _uploadRepository;
  final ReviewTemplateRepository _reviewTemplateRepository;
  final ReviewStepViolationRepository _reviewStepViolationRepository;

  ReviewRepositoryImpl(
    this._reviewLocationRepository,
    this._reviewStepFileRepository,
    this._uploadRepository,
    this._reviewTemplateRepository,
    this._reviewStepViolationRepository,
  );

  Future<Review?> getByUuid(String uuid) {
    return (database.select(database.reviews)..where((tbl) => tbl.uuid.equals(uuid))).getSingleOrNull();
  }

  Future<List<Review>> getByUuids(List<String> reviewUuids) {
    return (database.select(database.reviews)..where((tbl) => tbl.uuid.isIn(reviewUuids))).get();
  }

  Future<Review> create(
      {required String uuid,
      required String companyUuid,
      required int? taskRemoteId,
      required int templateId,
      required int remoteTemplateId,
      required int? articleId,
      required int remoteArticleId,
      required DateTime startedAt,
      required DateTime onDeviceStartedAt,
      required bool offline}) async {
    await database.into(database.reviews).insert(ReviewsCompanion.insert(
          companyUuid: companyUuid,
          remoteTaskId: Value(taskRemoteId),
          uuid: uuid,
          templateId: templateId,
          remoteTemplateId: remoteTemplateId,
          articleId: Value(articleId),
          remoteArticleId: remoteArticleId,
          startedAt: startedAt,
          onDeviceStartedAt: onDeviceStartedAt,
          offline: offline,
        ));

    return (database.select(database.reviews)..where((tbl) => tbl.uuid.equals(uuid))).getSingle();
  }

  Future update(String uuid,
      {DateTime? startedAt,
      DateTime? onDeviceStartedAt,
      DateTime? interruptedAt,
      DateTime? onDeviceInterruptedAt,
      DateTime? finishedAt,
      DateTime? onDeviceFinishedAt,
      DateTime? startPointUploadedAt,
      DateTime? interruptPointUploadedAt,
      DateTime? finishedUploadedAt,
      DateTime? commentsUploadedAt,
      DateTime? deletingMediaUploadedAt,
      DateTime? violationsUploadedAt}) async {
    return await (database.update(database.reviews)..where((tbl) => tbl.uuid.equals(uuid))).write(ReviewsCompanion(
      interruptedAt: interruptedAt != null ? Value(interruptedAt) : Value.absent(),
      onDeviceInterruptedAt: onDeviceInterruptedAt != null ? Value(onDeviceInterruptedAt) : Value.absent(),
      finishedAt: finishedAt != null ? Value(finishedAt) : Value.absent(),
      onDeviceFinishedAt: onDeviceFinishedAt != null ? Value(onDeviceFinishedAt) : Value.absent(),
      startedAt: startedAt != null ? Value(startedAt) : Value.absent(),
      onDeviceStartedAt: onDeviceStartedAt != null ? Value(onDeviceStartedAt) : Value.absent(),
      startPointUploadedAt: startPointUploadedAt != null ? Value(startPointUploadedAt) : Value.absent(),
      interruptPointUploadedAt: interruptPointUploadedAt != null ? Value(interruptPointUploadedAt) : Value.absent(),
      finishedUploadedAt: finishedUploadedAt != null ? Value(finishedUploadedAt) : Value.absent(),
      commentsUploadedAt: commentsUploadedAt != null ? Value(commentsUploadedAt) : Value.absent(),
      violationsUploadedAt: violationsUploadedAt != null ? Value(violationsUploadedAt) : Value.absent(),
      deletingMediaUploadedAt: deletingMediaUploadedAt != null ? Value(deletingMediaUploadedAt) : Value.absent(),
    ));
  }

  Future<List<Review>> getInProgressByRemoteArticleId(String companyUuid, int remoteArticleId) {
    return (database.select(database.reviews)
          ..where((tbl) =>
              tbl.companyUuid.equals(companyUuid) & tbl.remoteArticleId.equals(remoteArticleId) & tbl.finishedAt.isNull() & tbl.interruptedAt.isNull()))
        .get();
  }

  Future<List<Review>> getInProgressReviews(
    String companyUuid,
    List<int> articleIds,
  ) {
    return (database.select(database.reviews)
          ..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.remoteArticleId.isIn(articleIds) & tbl.remoteTaskId.isNull()))
        .get();
  }

  Future<List<Review>> getForArticle(String companyUuid, int articleId) {
    return getForArticles(companyUuid, [articleId]);
  }

  Future<List<Review>> getForArticles(String companyUuid, List<int> articlesIds) {
    return (database.select(database.reviews)
          ..where((tbl) => tbl.remoteTaskId.isNull() & tbl.companyUuid.equals(companyUuid) & tbl.remoteArticleId.isIn(articlesIds)))
        .get();
  }

  Future<bool> isFinished(String uuid) async {
    final review = (await getByUuid(uuid))!;

    // отчет еще в процессе прохождения
    if (review.finishedAt == null && review.interruptedAt == null) {
      return false;
    }

    if (review.startPointUploadedAt == null && review.interruptPointUploadedAt == null && review.finishedUploadedAt == null) {
      return false;
    }

    if (review.commentsUploadedAt == null || review.violationsUploadedAt == null || review.deletingMediaUploadedAt == null) {
      return false;
    }

    final hasNotUploadedLocations = await _reviewLocationRepository.hasNotUploadedForReview(review.uuid);
    if (hasNotUploadedLocations) {
      return false;
    }

    final hasNotUploadedFiles = await _reviewStepFileRepository.hasNotUploadedForReview(review.uuid);
    if (hasNotUploadedFiles) {
      return false;
    }

    return true;
  }

  Future deleteWithChildren(String uuid) async {
    final review = (await getByUuid(uuid));
    if (review != null) {
      await _reviewLocationRepository.deleteForReviewUuid(uuid);

      await _reviewStepFileRepository.deleteForReviewUuid(uuid);

      await _uploadRepository.deleteByReviewUuid(review.uuid);

      await _reviewTemplateRepository.deleteById(review.companyUuid, review.templateId);

      await _reviewStepViolationRepository.deleteByReviewUuid(review.uuid);

      await delete(review.uuid);
    }
  }

  Future delete(String uuid) {
    return (database.delete(database.reviews)..where((tbl) => tbl.uuid.equals(uuid))).go();
  }

  Future<List<Review>> getFullUploaded() {
    return (database.select(database.reviews)
          ..where((tbl) => tbl.startPointUploadedAt.isNotNull() & (tbl.interruptPointUploadedAt.isNotNull() | tbl.finishedUploadedAt.isNotNull())))
        .get();
  }

  Future<List<Review>> getStartedNotUploaded() {
    return (database.select(database.reviews)..where((tbl) => tbl.startPointUploadedAt.isNull())).get();
  }

  Future<List<Review>> getInterruptedNotUploaded() {
    return (database.select(database.reviews)..where((tbl) => tbl.interruptedAt.isNotNull() & tbl.interruptPointUploadedAt.isNull())).get();
  }

  Future<List<Review>> getNotFinishedUploaded() {
    return (database.select(database.reviews)..where((tbl) => tbl.finishedAt.isNotNull() & tbl.finishedUploadedAt.isNull())).get();
  }

  Future<Review?> getForTaskRemoteId(String companyUuid, int taskRemoteId) {
    return (database.select(database.reviews)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.remoteTaskId.equals(taskRemoteId))).getSingleOrNull();
  }

  Future<List<Review>> getNotAttachedViolations() {
    return (database.select(database.reviews)..where((tbl) => tbl.violationsUploadedAt.isNull() & (tbl.finishedAt.isNotNull() | tbl.interruptedAt.isNotNull())))
        .get();
  }

  Future<List<Review>> getNotAttachedComments() {
    return (database.select(database.reviews)..where((tbl) => tbl.commentsUploadedAt.isNull() & (tbl.finishedAt.isNotNull() | tbl.interruptedAt.isNotNull())))
        .get();
  }

  Future<List<Review>> getNotAttachedDeletingMedia() {
    return (database.select(database.reviews)
          ..where((tbl) => tbl.deletingMediaUploadedAt.isNull() & (tbl.finishedAt.isNotNull() | tbl.interruptedAt.isNotNull())))
        .get();
  }
}
