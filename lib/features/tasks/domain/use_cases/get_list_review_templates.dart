import 'package:leasing_company/features/reviews/domain/entities/review_template_mini_entity.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';

class GetListReviewTemplatesUseCase {
  final ReviewTemplateRepository repository;

  GetListReviewTemplatesUseCase(this.repository);

  Future<List<ReviewTemplateMiniEntity>> call(String companyUuid) {
    return repository.getAllByRemote(
      companyUuid: companyUuid,
      type: "task_template",
    );
  }
}
