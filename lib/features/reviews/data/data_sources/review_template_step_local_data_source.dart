import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';


abstract class ReviewTemplateStepLocalDataSource {
  Future<int> insert(ReviewTemplateStepModel step);

  Future<ReviewTemplateStepModel?> getByLocalId(
      String companyUuid, int localId);

  Future<List<ReviewTemplateStepModel>> getByTemplateLocalId(
      int templateLocalId);

  Future<bool> update(ReviewTemplateStepModel step);

  Future<List<int>> insertListSteps(List<ReviewTemplateStepModel> steps);
}