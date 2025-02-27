import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';

abstract class ReviewTemplateStepRepository {
  Future<ReviewTemplateStep?> getById(int stepId);

  Future<ReviewTemplateStep?> getByUuid(String stepUuid);

  Future<List<ReviewTemplateStep>> getForTemplate(String companyUuid, int templateId);

  Future<List<ReviewTemplateStep>> getForTemplateAndReview(String companyUuid, int templateId, String reviewUuid);

  Future<List<ReviewTemplateStep>> getStepsForDownload();

  Future updateContentImage(String companyUuid, int stepId, String contentImage);

  Future updateContentMask(String companyUuid, int stepId, String contentMask);

  Future<ReviewTemplateStep> create({
    required String companyUuid,
    int? remoteId,
    String? remoteUuid,
    int? parentId,
    required int templateId,
    String? reviewUuid,
    required String title,
    required String? subtitle,
    required String type,
    String? contentImage,
    String? contentMask,
    String? contentText,
    String? comment,
    int? formId,
    required bool required,
    required bool requiredCommentWhenSkipping,
    required bool expandable,
    required bool repeatable,
    required bool canHaveViolation,
    required int weight,
    required int? sectionId,
  });

  Future<ReviewTemplateStep> createCopyOf(String companyUuid, int id, {int? templateId, String? reviewUuid});

  Future deleteByTemplateId(int id);

  Future<int> insert(ReviewTemplateStepModel step);

  Future<List<int>> insertListSteps(List<ReviewTemplateStepModel> steps);

  Future<List<ReviewTemplateStepModel>> getByTemplateLocalId(int templateLocalId);

  Future<bool> update(ReviewTemplateStepModel step);
}
