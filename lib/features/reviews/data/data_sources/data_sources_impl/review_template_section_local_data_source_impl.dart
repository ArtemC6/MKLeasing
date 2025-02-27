import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_section_local_data_source.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateSectionLocalDataSourceImpl
    implements ReviewTemplateSectionLocalDataSource {
  Future<List<ReviewSection>> getSectionsByTemplateId(int templateId) async {
    return (database.select(database.reviewSections)
          ..where((tbl) => tbl.templateId.equals(templateId)))
        .get();
  }

  @override
  Future<ReviewSection?> getById(int id) async {
    return await (database.select(database.reviewSections)
      ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<int> insert(ReviewSection newSection) async {
      return await database
          .into(database.reviewSections)
          .insert(ReviewSectionsCompanion(
            remoteId: Value(newSection.remoteId),
            templateId: Value(newSection.templateId),
            parentId: Value(newSection.parentId),
            uuid: Value(newSection.uuid),
            title: Value(newSection.title),
            description: Value(newSection.description),
            subtitle: Value(newSection.subtitle),
            repeatable: Value(newSection.repeatable),
            isSelfCreated: Value(newSection.isSelfCreated),
          ));
  }

  @override
  Future deleteByTemplateId(int templateId) async {
    database.delete(database.reviewSections)
      ..where((tbl) => tbl.templateId.equals(templateId));
  }
}
