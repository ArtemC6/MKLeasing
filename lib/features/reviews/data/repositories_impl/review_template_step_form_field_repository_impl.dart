import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_form_field_local_data_source.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_entity.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_field_repository.dart';

class ReviewTemplateStepFormFieldRepositoryImpl
    extends ReviewTemplateStepFormFieldRepository {
  final ReviewTemplateStepFormFieldLocalDataSource _localDataSource;

  ReviewTemplateStepFormFieldRepositoryImpl(this._localDataSource);

  @override
  Future<int> insert(String companyUuid, int formLocalId,
      ReviewTemplateStepFormFieldEntity field) {
    return _localDataSource.insert(
        companyUuid: companyUuid, formLocalId: formLocalId, field: field);
  }

  Future<ReviewTemplateStepFormFieldEntity?> getByLocalId(int localId) async {
    var field = await _localDataSource.getByLocalId(localId);

    if (field == null) return null;

    return field.toEntity();
  }

  Future<List<ReviewTemplateStepFormFieldEntity>> getByFormsLocalIds(
      List<int> formsIdsWithFields) async {
    var fields = await _localDataSource.getByFormsLocalIds(formsIdsWithFields);

    return List<ReviewTemplateStepFormFieldEntity>.from(
        fields.map((e) => e.toEntity()));
  }
}
