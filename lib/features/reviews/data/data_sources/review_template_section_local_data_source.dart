import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewTemplateSectionLocalDataSource {
  Future<List<ReviewSection>> getSectionsByTemplateId(int templateId);

  Future<int> insert(ReviewSection newSection);

  Future deleteByTemplateId(int templateId);

  Future<ReviewSection?> getById(int id);
}