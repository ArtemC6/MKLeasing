import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewTemplateSectionRepository {
  Future<List<ReviewSection>> getSectionsByTemplateId(int templateId);

  Future<ReviewSection?> getById(int id);

  Future<int> insert(ReviewSection newSection);

  Future deleteByTemplateId(int templateId);
}
