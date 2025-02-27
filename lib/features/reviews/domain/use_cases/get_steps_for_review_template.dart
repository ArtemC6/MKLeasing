import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/main.dart';

class GetStepsForReviewTemplate extends UseCase<List<ReviewTemplateStepModel>,
    GetStepsForReviewTemplateParams> {
  final ReviewTemplateStepRepository reviewTemplateStepRepository = getIt();

  @override
  Future<List<ReviewTemplateStepModel>> call(
      GetStepsForReviewTemplateParams params) {
    return reviewTemplateStepRepository
        .getByTemplateLocalId(params.templateLocalId);
  }
}

class GetStepsForReviewTemplateParams {
  final int templateLocalId;

  GetStepsForReviewTemplateParams({required this.templateLocalId});
}
