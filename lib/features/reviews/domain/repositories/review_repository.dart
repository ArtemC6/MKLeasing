import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewRepository {
  Future<Review?> getByUuid(String uuid);

  Future<List<Review>> getByUuids(List<String> reviewUuids);

  Future<Review> create({
    required String uuid,
    required String companyUuid,
    required int? taskRemoteId,
    required int templateId,
    required int remoteTemplateId,
    required int? articleId,
    required int remoteArticleId,
    required DateTime startedAt,
    required DateTime onDeviceStartedAt,
    required bool offline,
  });

  Future update(
    String uuid, {
    DateTime? startedAt,
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
    DateTime? violationsUploadedAt,
  });

  Future<List<Review>> getInProgressByRemoteArticleId(String companyUuid, int remoteArticleId);

  Future<List<Review>> getInProgressReviews(
    String companyUuid,
    List<int> articleIds,
  );

  Future<List<Review>> getForArticle(String companyUuid, int articleId);

  Future<List<Review>> getForArticles(String companyUuid, List<int> articlesIds);

  Future<bool> isFinished(String uuid);

  Future deleteWithChildren(String uuid);

  Future delete(String uuid);

  Future<List<Review>> getFullUploaded();

  Future<List<Review>> getStartedNotUploaded();

  Future<List<Review>> getInterruptedNotUploaded();

  Future<List<Review>> getNotFinishedUploaded();

  Future<Review?> getForTaskRemoteId(String companyUuid, int taskRemoteId);

  Future<List<Review>> getNotAttachedViolations();

  Future<List<Review>> getNotAttachedComments();

  Future<List<Review>> getNotAttachedDeletingMedia();
}
