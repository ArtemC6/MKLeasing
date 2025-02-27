import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_section_repository.dart';

class GetSectionsForReviewTemplate {
  final ReviewTemplateSectionRepository _repository;

  GetSectionsForReviewTemplate(this._repository);

  Future<List<ReviewSection>> call(int templateId) =>
      _repository.getSectionsByTemplateId(templateId);
}
