import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_field_model.dart';


abstract class ReviewTemplateStepFormFieldLocalDataSource {
  Future<int> insert({
    required String companyUuid,
    required int formLocalId,
    required ReviewTemplateStepFormFieldEntity field,
  });

  Future<ReviewTemplateStepFormFieldModel?> getByLocalId(int localId);

  Future<List<ReviewTemplateStepFormFieldModel>> getByFormsLocalIds(
      List<int> formsIdsWithFields);
}
