import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_local_data_source.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateLocalDataSourceImpl implements ReviewTemplateLocalDataSource {
  @override
  Future<ReviewTemplateModel?> getByLocalId(int localId) async {
    ReviewTemplate? template = await (database.select(database.reviewTemplates)..where((tbl) => tbl.id.equals(localId))).getSingleOrNull();
    if (template == null) return null;

    return ReviewTemplateModel.fromDBModel(template);
  }

  Future<ReviewTemplateModel?> getByRemoteId(int remoteId, String companyUuid) async {
    final templates = await (database.select(database.reviewTemplates)
          ..where((tbl) => tbl.remoteId.equals(remoteId) & tbl.parentId.isNull() & tbl.companyUuid.equals(companyUuid)))
        .get();

    final template = templates.isNotEmpty ? templates.first : null;
    
    if (template == null) return null;
    return ReviewTemplateModel.fromDBModel(template);
  }

  @override
  Future<int> insert({
    required String companyUuid,
    required ReviewTemplateModel reviewTemplate,
  }) async {
    return await database.into(database.reviewTemplates).insert(ReviewTemplatesCompanion.insert(
          remoteId: reviewTemplate.remoteId,
          parentId: Value(reviewTemplate.parentId),
          companyUuid: companyUuid,
          name: reviewTemplate.name,
          description: Value(reviewTemplate.description),
          expandable: reviewTemplate.expandable,
          private: reviewTemplate.private,
          repeatable: reviewTemplate.repeatable,
          rejectionAvailable: Value(reviewTemplate.rejectionAvailable),
          delegationAvailable: Value(reviewTemplate.delegationAvailable),
          isRework: Value(reviewTemplate.isRework),
          simpleSignatureEnabled: Value(reviewTemplate.simpleSignatureEnabled),
          simpleSignatureFile: Value(reviewTemplate.simpleSignatureFile),
          isOpened: Value(reviewTemplate.isOpened),
        ));
  }
}
