import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_entity.dart';

abstract class ReviewTemplateStepFormFieldRepository {
  Future<int> insert(String companyUuid, int formLocalId,
      ReviewTemplateStepFormFieldEntity field);

  Future<List<ReviewTemplateStepFormFieldEntity>> getByFormsLocalIds(
      List<int> formsIdsWithFields);
}
