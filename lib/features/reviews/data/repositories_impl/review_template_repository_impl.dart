import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_local_data_source.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_remote_data_source.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_mini_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_section_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateRepositoryImpl implements ReviewTemplateRepository {
  final ReviewTemplateStepRepository _reviewTemplateStepRepository;
  final ReviewTemplateRemoteDataSource _remoteDataSource;
  final ReviewTemplateLocalDataSource _localDataSource;
  final ReviewTemplateSectionRepository _reviewTemplateSectionRepository;

  ReviewTemplateRepositoryImpl(
    this._reviewTemplateStepRepository,
    this._remoteDataSource,
    this._localDataSource,
    this._reviewTemplateSectionRepository,
  );

  Future<ReviewTemplate?> getById(String companyUuid, int templateId) {
    return (database.select(database.reviewTemplates)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.id.equals(templateId))).getSingleOrNull();
  }

  Future<ReviewTemplateModel?> getEntityById(String companyUuid, int templateId) async {
    final reviewTemplate =
        await (database.select(database.reviewTemplates)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.id.equals(templateId))).getSingleOrNull();

    return reviewTemplate != null ? ReviewTemplateModel.fromDBModel(reviewTemplate) : null;
  }

  Future<List<ReviewTemplateArticle>> getReviewTemplatesToArticlesList(
    String companyUuid,
    List<int> articlesIds,
  ) async {
    return (database.select(database.reviewTemplateArticles)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.articleId.isIn(articlesIds))).get();
  }

  Future<List<ReviewTemplate>> getList(String companyUuid, int articleId) async {
    final pivots =
        await (database.select(database.reviewTemplateArticles)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.articleId.equals(articleId))).get();

    return (database.select(database.reviewTemplates)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.id.isIn(pivots.map((e) => e.templateId))))
        .get();
  }

  Future<List<ReviewTemplate>> getListForArticles(String companyUuid, List<int> articlesIds) async {
    final pivots =
        await (database.select(database.reviewTemplateArticles)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.articleId.isIn(articlesIds))).get();

    return (database.select(database.reviewTemplates)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.id.isIn(pivots.map((e) => e.templateId))))
        .get();
  }

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
    bool isOpened = false,
  }) async {
    final id = await database.into(database.reviewTemplates).insert(
          ReviewTemplatesCompanion.insert(
            remoteId: remoteId,
            parentId: Value(parentId),
            companyUuid: companyUuid,
            name: name,
            description: Value(description),
            expandable: expandable,
            repeatable: repeatable,
            private: private,
            isRework: Value(isRework),
            rejectionAvailable: Value(rejectionAvailable),
            delegationAvailable: Value(delegationAvailable),
            simpleSignatureEnabled: Value(simpleSignatureEnabled),
            isOpened: Value(isOpened),
          ),
        );

    return (database.select(database.reviewTemplates)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<ReviewTemplate> createCopyOf(String companyUuid, int templateId) async {
    final template = (await getById(companyUuid, templateId))!;
    final copyOfTemplate = await create(
      companyUuid: companyUuid,
      remoteId: template.remoteId,
      parentId: template.id,
      name: template.name,
      description: template.description,
      expandable: template.expandable,
      repeatable: template.repeatable,
      private: template.private,
      rejectionAvailable: template.rejectionAvailable,
      delegationAvailable: template.delegationAvailable,
      isRework: template.isRework,
      simpleSignatureEnabled: template.simpleSignatureEnabled ?? true,
      isOpened: template.isOpened,
    );

    final steps = await _reviewTemplateStepRepository.getForTemplate(companyUuid, templateId);

    final futures = steps.map((step) => _reviewTemplateStepRepository.createCopyOf(companyUuid, step.id, templateId: copyOfTemplate.id)).toList();

    await Future.wait(futures);

    return copyOfTemplate;
  }

  Future<List<ReviewTemplate>> getListByIds({required String companyUuid, required List<int> reviewsTemplatesIds}) async {
    return (database.select(database.reviewTemplates)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.id.isIn(reviewsTemplatesIds))).get();
  }

  Future deleteById(String companyUuid, int templateId) async {
    final template = (await getById(companyUuid, templateId))!;

    await _reviewTemplateStepRepository.deleteByTemplateId(template.id);
    await _reviewTemplateSectionRepository.deleteByTemplateId(template.id);

    return (database.delete(database.reviewTemplates)..where((tbl) => tbl.id.equals(templateId))).go();
  }

  Future<int> insert(String companyUuid, ReviewTemplateModel reviewTemplate) {
    return _localDataSource.insert(
      companyUuid: companyUuid,
      reviewTemplate: reviewTemplate,
    );
  }

  Future<ReviewTemplateModel?> getByRemoteId(int remoteId, String companyUuid) {
    return _localDataSource.getByRemoteId(remoteId, companyUuid);
  }

  @override
  Future<List<ReviewTemplateMiniEntity>> getAllByRemote({required String companyUuid, required String type}) async {
    var reviewTemplates = await _remoteDataSource.getAll(companyUuid: companyUuid, type: type);

    return List<ReviewTemplateMiniEntity>.from(reviewTemplates.map((template) => template.toEntity()));
  }

  Future<ReviewTemplateModel?> getByLocalId(int localId) {
    return _localDataSource.getByLocalId(localId);
  }

  Future<bool> checkAvailability(int reviewTemplateId, String companyUuid) async {
    return await _remoteDataSource.checkAvailability(reviewTemplateId, companyUuid);
  }
}
