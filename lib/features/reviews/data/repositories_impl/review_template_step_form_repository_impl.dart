import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_form_local_data_source.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_repository.dart';

class ReviewTemplateStepFormRepositoryImpl
    extends ReviewTemplateStepFormRepository {
  final ReviewTemplateStepFormLocalDataSource _localDataSource;

  ReviewTemplateStepFormRepositoryImpl(this._localDataSource);

  Future<int> insert(String companyUuid, int localTemplateId,
      ReviewTemplateStepFormModel form) {
    return _localDataSource.insert(companyUuid, localTemplateId, form);
  }

  Future<ReviewTemplateStepFormModel?> getByLocalId(
      String companyUuid, int localId) {
    return _localDataSource.getByLocalId(companyUuid, localId);
  }

  Future<List<ReviewTemplateStepFormModel>> getByLocalIds(
      List<int> stepsIdsWithForms) {
    return _localDataSource.getByLocalIds(stepsIdsWithForms);
  }
}
