import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';

abstract class ReviewTemplateStepFormRepository {
  Future<int> insert(String companyUuid, int localTemplateId,
      ReviewTemplateStepFormModel form);

  Future<List<ReviewTemplateStepFormModel>> getByLocalIds(
      List<int> stepsIdsWithForms);

  Future<ReviewTemplateStepFormModel?> getByLocalId(
      String companyUuid, int localId);
}
