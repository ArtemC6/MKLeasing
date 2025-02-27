import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_section_local_data_source.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_section_repository.dart';

class ReviewTemplateSectionRepositoryImpl
    implements ReviewTemplateSectionRepository {
  final ReviewTemplateSectionLocalDataSource _datasource;

  ReviewTemplateSectionRepositoryImpl(this._datasource);

  Future<List<ReviewSection>> getSectionsByTemplateId(int templateId) =>
      _datasource.getSectionsByTemplateId(templateId);

  Future<int> insert(ReviewSection newSection) =>
      _datasource.insert(newSection);

  @override
  Future deleteByTemplateId(int templateId) =>
      _datasource.deleteByTemplateId(templateId);

  @override
  Future<ReviewSection?> getById(int id) => _datasource.getById(id);
}
