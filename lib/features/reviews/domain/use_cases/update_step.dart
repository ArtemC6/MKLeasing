import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';

class UpdateStepUseCase {
  final ReviewTemplateStepRepository _repository;

  UpdateStepUseCase(this._repository);

  Future call(ReviewTemplateStepModel step) => _repository.update(step);

}