import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';

class AddUsersStepsToReviewTemplate {
  final ReviewTemplateStepRepository reviewTemplateStepRepository;

  AddUsersStepsToReviewTemplate(this.reviewTemplateStepRepository);

  Future<List<int>> call(List<ReviewTemplateStepModel> steps) async =>
      reviewTemplateStepRepository.insertListSteps(steps);
}
