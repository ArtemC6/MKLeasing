import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_mini_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';

abstract class ReviewTemplateRepository {
  Future<ReviewTemplate?> getById(String companyUuid, int templateId);

  Future<ReviewTemplateModel?> getEntityById(String companyUuid, int templateId);

  Future<List<ReviewTemplateArticle>> getReviewTemplatesToArticlesList(
    String companyUuid,
    List<int> articlesIds,
  );

  Future<List<ReviewTemplate>> getList(String companyUuid, int articleId);

  Future<List<ReviewTemplate>> getListForArticles(String companyUuid, List<int> articlesIds);

  Future<ReviewTemplate> create({
    required int remoteId,
    required int? parentId,
    required String companyUuid,
    required String name,
    required String? description,
    required bool expandable,
    required bool repeatable,
    required bool private,
    required bool isRework,
    required bool rejectionAvailable,
    required bool delegationAvailable,
    required bool? simpleSignatureEnabled,
  });

  Future<ReviewTemplate> createCopyOf(String companyUuid, int templateId);

  Future<List<ReviewTemplate>> getListByIds({
    required String companyUuid,
    required List<int> reviewsTemplatesIds,
  });

  Future deleteById(String companyUuid, int templateId);

  Future<int> insert(String companyUuid, ReviewTemplateModel reviewTemplate);

  Future<ReviewTemplateModel?> getByLocalId(int localId);

  Future<ReviewTemplateModel?> getByRemoteId(int remoteId, String companyUuid);

  Future<List<ReviewTemplateMiniEntity>> getAllByRemote({required String companyUuid, required String type});

  Future<bool> checkAvailability(int reviewTemplateId, String companyUuid);
}
